local M = {}

local function range_from_marks(start_mark, end_mark, mode)
    local start_pos = vim.api.nvim_buf_get_mark(0, start_mark)
    local end_pos = vim.api.nvim_buf_get_mark(0, end_mark)
    if start_pos[1] == 0 or end_pos[1] == 0 then
        return nil
    end

    local start_row = start_pos[1] - 1
    local start_col = start_pos[2]
    local end_row = end_pos[1] - 1
    local end_col = end_pos[2]

    if start_row > end_row or (start_row == end_row and start_col > end_col) then
        start_row, end_row = end_row, start_row
        start_col, end_col = end_col, start_col
    end

    if mode == "line" or mode == "V" then
        start_col = 0
        end_col = #vim.api.nvim_buf_get_lines(0, end_row, end_row + 1, false)[1]
    else
        end_col = end_col + 1
    end

    return start_row, start_col, end_row, end_col
end

local function is_block_mode(mode)
    return mode == "block" or mode == "\22"
end

local function change_text(command, action, text, before_start, after_end)
    if action == "wrap" then
        return "\\" .. command .. "{" .. text .. "}"
    end

    local prefix = "\\" .. command .. "{"
    local suffix = "}"
    if before_start == prefix and after_end == suffix then
        return text, true
    end

    return text:match("^\\" .. command .. "%{([%s%S]*)%}$")
end

local function change_block(command, action, start_mark, end_mark)
    local start_pos = vim.api.nvim_buf_get_mark(0, start_mark)
    local end_pos = vim.api.nvim_buf_get_mark(0, end_mark)
    if start_pos[1] == 0 or end_pos[1] == 0 then
        return
    end

    local start_row = math.min(start_pos[1], end_pos[1]) - 1
    local end_row = math.max(start_pos[1], end_pos[1]) - 1
    local start_col = math.min(start_pos[2], end_pos[2])
    local end_col = math.max(start_pos[2], end_pos[2]) + 1
    local prefix = "\\" .. command .. "{"
    local suffix = "}"

    for row = end_row, start_row, -1 do
        local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1] or ""
        local line_start_col = math.min(start_col, #line)
        local line_end_col = math.min(end_col, #line)
        if line_start_col < line_end_col then
            local text = vim.api.nvim_buf_get_text(0, row, line_start_col, row, line_end_col, {})[1]
            local before_start = vim.api.nvim_buf_get_text(0, row, math.max(line_start_col - #prefix, 0), row,
                line_start_col, {})[1]
            local after_end = vim.api.nvim_buf_get_text(0, row, line_end_col, row, line_end_col + #suffix, {})[1]
            local changed, remove_outer = change_text(command, action, text, before_start, after_end)

            if changed and remove_outer then
                vim.api.nvim_buf_set_text(0, row, line_end_col, row, line_end_col + #suffix, {})
                vim.api.nvim_buf_set_text(0, row, line_start_col - #prefix, row, line_start_col, {})
            elseif changed then
                vim.api.nvim_buf_set_text(0, row, line_start_col, row, line_end_col, { changed })
            end
        end
    end
end

local function change_range(command, action, start_mark, end_mark, mode)
    if is_block_mode(mode) then
        change_block(command, action, start_mark, end_mark)
        return
    end

    local start_row, start_col, end_row, end_col = range_from_marks(start_mark, end_mark, mode)
    if not start_row then
        return
    end

    local lines = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
    if #lines == 0 then
        return
    end

    if action == "wrap" then
        lines[1] = "\\" .. command .. "{" .. lines[1]
        lines[#lines] = lines[#lines] .. "}"
    else
        local prefix = "\\" .. command .. "{"
        local suffix = "}"
        local before_start = vim.api.nvim_buf_get_text(0, start_row, math.max(start_col - #prefix, 0), start_row,
            start_col, {})[1]
        local after_end = vim.api.nvim_buf_get_text(0, end_row, end_col, end_row, end_col + #suffix, {})[1]
        local inner_text, remove_outer = change_text(command, action, table.concat(lines, "\n"), before_start,
            after_end)
        if remove_outer then
            vim.api.nvim_buf_set_text(0, end_row, end_col, end_row, end_col + #suffix, {})
            vim.api.nvim_buf_set_text(0, start_row, start_col - #prefix, start_row, start_col, {})
            return
        end

        if not inner_text then
            return
        end
        lines = vim.split(inner_text, "\n", { plain = true })
    end

    vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, lines)
end

function _G.TwentyTexOperator(mode)
    local operator = vim.b.twenty_tex_operator
    if not operator then
        return
    end

    change_range(operator.command, operator.action, "[", "]", mode)
end

local function change_visual(command, action)
    local mode = vim.fn.visualmode()
    vim.cmd("normal! \27")
    change_range(command, action, "<", ">", mode)
end

function M.setup()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        group = vim.api.nvim_create_augroup("TwentyTex", { clear = true }),
        callback = function(event)
            local operator = function(command, action)
                vim.b.twenty_tex_operator = { command = command, action = action }
                vim.go.operatorfunc = "v:lua.TwentyTexOperator"
                return "g@"
            end

            vim.keymap.set("n", "<leader>tb", function()
                return operator("textbf", "wrap")
            end, {
                buffer = event.buf,
                expr = true,
                desc = "LaTeX bold motion",
            })
            vim.keymap.set("n", "<leader>ti", function()
                return operator("textit", "wrap")
            end, {
                buffer = event.buf,
                expr = true,
                desc = "LaTeX italic motion",
            })
            vim.keymap.set("n", "<leader>tB", function()
                return operator("textbf", "unwrap")
            end, {
                buffer = event.buf,
                expr = true,
                desc = "LaTeX unbold motion",
            })
            vim.keymap.set("n", "<leader>tI", function()
                return operator("textit", "unwrap")
            end, {
                buffer = event.buf,
                expr = true,
                desc = "LaTeX unitalic motion",
            })

            vim.keymap.set("v", "<leader>tb", function()
                change_visual("textbf", "wrap")
            end, {
                buffer = event.buf,
                desc = "LaTeX bold selection",
            })
            vim.keymap.set("v", "<leader>ti", function()
                change_visual("textit", "wrap")
            end, {
                buffer = event.buf,
                desc = "LaTeX italic selection",
            })
            vim.keymap.set("v", "<leader>tB", function()
                change_visual("textbf", "unwrap")
            end, {
                buffer = event.buf,
                desc = "LaTeX unbold selection",
            })
            vim.keymap.set("v", "<leader>tI", function()
                change_visual("textit", "unwrap")
            end, {
                buffer = event.buf,
                desc = "LaTeX unitalic selection",
            })
        end,
    })
end

return M

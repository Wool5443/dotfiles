return function()
    local gitsigns = require("gitsigns")
    if vim.fn.executable("delta") ~= 1 then
        vim.notify("delta is required for git hunk previews", vim.log.levels.WARN)
        return
    end

    local line = vim.api.nvim_win_get_cursor(0)[1]
    local hunk
    for _, candidate in ipairs(gitsigns.get_hunks() or {}) do
        local first = math.max(1, math.min(vim.api.nvim_buf_line_count(0), candidate.added.start))
        local last = first + math.max(1, candidate.added.count) - 1
        if line >= first and line <= last then
            hunk = candidate
            break
        end
    end
    if not hunk then
        return
    end

    local width = math.max(1, math.min(120, vim.o.columns - 4))
    local patch = { "--- a/" .. vim.fn.expand("%:t"), "+++ b/" .. vim.fn.expand("%:t"), hunk.head }
    vim.list_extend(patch, hunk.lines)
    local result = vim.system({ "delta", "--paging=never", "--color-only", "--width=" .. width }, {
        stdin = table.concat(patch, "\n") .. "\n",
        text = true,
    }):wait()
    if result.code ~= 0 then
        vim.notify(result.stderr or "delta preview failed", vim.log.levels.ERROR)
        return
    end

    local output = result.stdout or ""
    local height = math.max(1, math.min(select(2, output:gsub("\n", "")), vim.o.lines - 6))
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        width = width,
        height = height,
        style = "minimal",
        border = "rounded",
        title = " Git hunk · delta ",
        title_pos = "center",
    })
    vim.bo[buf].bufhidden = "wipe"
    local channel = vim.api.nvim_open_term(buf, {})
    vim.api.nvim_chan_send(channel, (output:gsub("\n", "\r\n")))
    for _, key in ipairs({ "q", "<Esc>" }) do
        vim.keymap.set("n", key, function()
            vim.api.nvim_win_close(win, true)
        end, { buffer = buf, silent = true })
    end
end

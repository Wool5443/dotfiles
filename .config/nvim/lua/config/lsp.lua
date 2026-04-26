local M = {}

function M.setup()
    require("mason").setup {
        ensure_installed = {
            "basedpyright",
            "bash-language-server",
            "docker-compose-language-service",
            "docker-language-server",
            "dockerfile-language-server",
            "lua-language-server",
            "ruff",
            "texlab",
            "tinymist",
        }
    }

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.config("*", {
        capabilities = capabilities
    })
    vim.lsp.config("basedpyright", {
        settings = {
            basedpyright = {
                analysis = {
                    diagnosticMode = "openFilesOnly",
                    typeCheckingMode = "basic",
                    inlayHints = {
                        callArgumentNames = true
                    }
                },
            },
        },
    })
    vim.lsp.config("tinymist", {
        settings = {
            formatterMode = "typstyle",
            exportPdf = "onType",
            semanticTokens = "disable"
        }
    })
    vim.lsp.config("lua_ls", {
        root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local config_root = vim.fn.stdpath("config")

            if fname == "" then
                on_dir(config_root)
                return
            end

            local normalized = vim.fs.normalize(fname)
            local config_root_norm = vim.fs.normalize(config_root)
            local fname_real = vim.uv.fs_realpath(normalized) or normalized
            local config_real = vim.uv.fs_realpath(config_root_norm) or config_root_norm

            if
                normalized:sub(1, #config_root_norm) == config_root_norm
                or fname_real:sub(1, #config_real) == config_real
            then
                on_dir(config_real)
                return
            end

            local project_root = vim.fs.root(normalized, { ".luarc.json", ".luarc.jsonc", ".luacheckrc", "stylua.toml" })
            on_dir(project_root or vim.fs.dirname(normalized))
        end,
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if
                    path ~= vim.fn.stdpath("config")
                    and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
                then
                    return
                end
            end

            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                    version = "LuaJIT",
                    path = {
                        "lua/?.lua",
                        "lua/?/init.lua",
                    },
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                    maxPreload = 2000,
                    preloadFileSize = 200,
                },
            })
        end,
        settings = {
            Lua = {},
        },
    })

    vim.lsp.enable("lua_ls")
    vim.lsp.enable("clangd")
    vim.lsp.enable("basedpyright")
    vim.lsp.enable("ruff")
    vim.lsp.enable("tinymist")
    vim.lsp.enable("bashls")
    vim.lsp.enable("rust_analyzer")
    vim.lsp.enable("texlab")

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, { desc = "Workspace symbols" })
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, { desc = "Code action" })
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, { desc = "LSP references" })
    vim.keymap.set("n", "<f2>", vim.lsp.buf.rename, { desc = "LSP rename" })
    vim.keymap.set({ "n", "v" }, "<C-f>", vim.lsp.buf.format, { desc = "LSP format" })

    require("lsp_signature").setup {
        bind = true,
        floating_window = true,
        hint_enable = true,
        handler_opts = {
            border = "rounded"
        },
        max_height = 12,
        max_width = 80,
        hint_prefix = "🐼 ",
    }
end

return M

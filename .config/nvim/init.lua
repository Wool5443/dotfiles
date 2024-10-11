vim.opt.winborder = "rounded"
vim.opt.hlsearch = false
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.langmap =
'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("Twenty", { clear = true }),
    callback = function()
        -- Get buffer options
        local buftype = vim.bo.buftype
        local readonly = vim.bo.readonly
        local modifiable = vim.bo.modifiable

        -- Only save if the buffer is normal, not readonly, and modifiable
        if buftype == "" and not readonly and modifiable then
            vim.cmd("silent! w") -- Save current buffer
        end
    end,
})

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>", ":noh<CR>")
vim.keymap.set({ "n", "v" }, "<C-s>", ":w<CR>")
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d')
vim.keymap.set("n", "<C-t>", "<C-e>", { noremap = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n>")

vim.keymap.set("n", "<CR>", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")
vim.keymap.set("n", "<S-CR>", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")

vim.pack.add {
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/kdheepak/lazygit.nvim" },
    { src = "https://github.com/Civitasv/cmake-tools.nvim" },
    { src = "https://github.com/olimorris/onedarkpro.nvim" },
    { src = "https://github.com/cappyzawa/trim.nvim" },
    { src = "https://github.com/pogyomo/cppguard.nvim" },
    { src = "https://github.com/onsails/lspkind.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/hrsh7th/cmp-path" },
    { src = "https://github.com/hrsh7th/cmp-cmdline" },
    { src = "https://github.com/hrsh7th/cmp-buffer" },
    { src = "https://github.com/danymat/neogen" },
    { src = "https://github.com/ray-x/lsp_signature.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/lervag/vimtex" },
    { src = "https://github.com/kylechui/nvim-surround" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    {
        src = "https://github.com/folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
-- vim.pack.update()

require("mason").setup()

-- Set up lspconfig
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = vim.lsp.config
vim.lsp.config["lua_ls"] = {
    capabilities = capabilities
}
vim.lsp.enable("lua_ls")
vim.lsp.config["clangd"] = {
    capabilities = capabilities
}
vim.lsp.enable("clangd")
vim.lsp.config["ruff"] = {
    capabilities = capabilities
}
vim.lsp.enable("ruff")
vim.lsp.config["basedpyright"] = {
    capabilities = capabilities,
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic",
            },
        },
    },
}
vim.lsp.enable("basedpyright")
vim.lsp.config["bashls"] = {
    capabilities = capabilities
}
vim.lsp.enable("bashls")
vim.lsp.config["rust_analyzer"] = {
    capabilities = capabilities
}
vim.lsp.enable("rust_analyzer")
vim.lsp.config["texlab"] = {
    capabilities = capabilities
}
vim.lsp.enable("texlab")

-- nvim-autopairs
require("nvim-autopairs").setup()

-- colors
vim.cmd("colorscheme onedark_dark")

-- snippets
require("luasnip").setup { enable_autosnippets = true }
require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/snippets/" }

-- treesitter
require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        incremental_selection = true,
        indent = true,
    },
}

-- nvim tree
local nvim_tree_api = require "nvim-tree.api"
require("nvim-tree").setup {
    filters = {
        dotfiles = false,
        git_ignored = false,
    },
    git = {
        enable = true,
    },
}
vim.keymap.set("n", "<C-e>", nvim_tree_api.tree.toggle)
vim.keymap.set("n", "<C-A-r>", nvim_tree_api.tree.reload)

-- lazygit
vim.keymap.set("n", "<C-g>", ":LazyGit<CR>")

-- telescope
local telescope_builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files)
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep)
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers)
vim.keymap.set("n", "<leader>fs", telescope_builtin.lsp_workspace_symbols)
vim.keymap.set("n", "<leader>fr", telescope_builtin.lsp_references)
vim.keymap.set("n", "<leader>fd", telescope_builtin.lsp_definitions)
vim.keymap.set("n", "<leader>fi", telescope_builtin.lsp_implementations)
vim.keymap.set("n", "<leader>fm", telescope_builtin.man_pages)

-- cmake
require("cmake-tools").setup {
    cmake_command = 'cmake',
    ctest_command = 'ctest',
    cmake_use_preset = true,
    cmake_regenerate_on_save = true,
    cmake_generate_options = {
        '-DCMAKE_BUILD_TYPE=Debug',
        '-GNinja',
        '-DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE',
    },
    cmake_build_options = {
        '--parallel 6',
    },
    cmake_soft_link_compile_commands = false,
    cmake_build_directory = 'build',
    cmake_kits_path = '~/.local/share/CMakeTools/cmake-tools-kits.json',
}

vim.keymap.set("n", "<f7>", ":CMakeBuild<CR>")
vim.keymap.set("n", "<f5>", ":CMakeRun<CR>")
vim.keymap.set("n", "<f6>", ":CMakeSelectLaunchTarget<CR>")

-- trim
require("trim").setup {
    ft_blocklist = {},
    patterns = {},
    trim_on_write = true,
    trim_trailing = true,
    trim_last_line = false,
    trim_first_line = true,
    highlight = false,
    highlight_bg = '#ff0000',
    highlight_ctermbg = 'red',
    notifications = true,
}

-- lsp
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references)
vim.keymap.set("n", "<f2>", vim.lsp.buf.rename)
vim.keymap.set({ "n", "v" }, "<C-f>", vim.lsp.buf.format)

-- comment
vim.keymap.set("n", "<C-/>", "gcc", { remap = true })
vim.keymap.set("v", "<C-/>", "gc", { remap = true })

-- cppguard
local luasnip = require("luasnip")
luasnip.add_snippets("cpp", {
    require("cppguard").snippet_luasnip("guard")
})

-- cmp
local cmp = require "cmp"
cmp.setup {
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),             -- Move to previous completion item
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),           -- Move to previous completion item
        ["<C-j>"] = cmp.mapping.select_next_item(),             -- Move to next completion item
        ["<Tab>"] = cmp.mapping.select_next_item(),             -- Move to next completion item
        ["<C-Space>"] = cmp.mapping.confirm({ select = true }), -- Confirm selected completion
        ["<C-e>"] = cmp.mapping.abort(),                        -- Abort completion
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For luasnip users.
        { name = "buffer" },
    })
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})


-- lspkind
local lspkind = require "lspkind"
cmp.setup {
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = {
                -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                -- can also be a function to dynamically calculate max width such as
                -- menu = function() return math.floor(0.45 * vim.o.columns) end,
                menu = 50,            -- leading text (labelDetails)
                abbr = 50,            -- actual suggestion item
            },
            ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                -- ...
                return vim_item
            end
        })
    }
}

-- todo-comments
require("todo-comments").setup()

--neogen
require("neogen").setup {}

-- lsp-signature
require("lsp_signature").setup {
    bind = true,            -- This is mandatory, otherwise border config won't get registered.
    floating_window = true, -- Show signature in a floating window.
    hint_enable = true,     -- Enable virtual text hints.
    handler_opts = {
        border = 'rounded'  -- 'single', 'double', 'rounded', 'solid', 'shadow'
    },
    -- You can tweak these parameters to adjust the behavior to your preference.
    max_height = 12,
    max_width = 80,
    hint_prefix = '🐼 ', -- Can be any symbol you prefer
}

-- vimtex
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_open_on_warning = 0

-- nvim-surround
require("nvim-surround").setup {}

-- lazydev
require("lazydev").setup()

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("Twenty", { clear = true }),
    callback = function()
        local buftype = vim.bo.buftype
        local readonly = vim.bo.readonly
        local modifiable = vim.bo.modifiable

        if buftype == "" and not readonly and modifiable then
            vim.cmd("silent! w") -- Save current buffer
        end
    end,
})

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader>o", function()
    vim.cmd.write()
    vim.cmd.source(vim.env.MYVIMRC)
end, { desc = "Save and source config" })
vim.keymap.set("n", "<leader>w", ":write<CR>", { desc = "Write file" })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit window" })
vim.keymap.set({ "n", "v" }, "<C-s>", ":w<CR>", { desc = "Write file" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete to system clipboard" })
vim.keymap.set("n", "<C-t>", "<C-e>", { noremap = true, desc = "Scroll down" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<CR>", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>", { desc = "Insert line below" })
vim.keymap.set("n", "<S-CR>", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
    { desc = "Insert line above" })

vim.pack.add {
    { src = "https://github.com/navarasu/onedark.nvim" },
    { src = "https://github.com/EdenEast/nightfox.nvim" },

    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/Civitasv/cmake-tools.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/lervag/vimtex" },
    { src = "https://github.com/neovim/nvim-lspconfig" },

    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-buffer" },
    { src = "https://github.com/hrsh7th/cmp-cmdline" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/hrsh7th/cmp-path" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
    { src = "https://github.com/onsails/lspkind.nvim" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/pogyomo/cppguard.nvim" },
    { src = "https://github.com/kylechui/nvim-surround" },

    { src = "https://github.com/danymat/neogen" },
    { src = "https://github.com/cappyzawa/trim.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/folke/trouble.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },

    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
    { src = "https://github.com/kdheepak/lazygit.nvim" },

    { src = "https://github.com/arminveres/md-pdf.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/ray-x/lsp_signature.nvim" },
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
}

-- Update command
vim.api.nvim_create_user_command("PluginsUpdate", function()
    vim.pack.update()
end, {})

-- Set up lsp
require("config.lsp").setup()

-- nvim-autopairs
require("nvim-autopairs").setup()

-- which-key
require("which-key").setup()

-- Colors
local colorscheme_file = vim.fn.stdpath("state") .. "/colorscheme"
local onedark_style_file = vim.fn.stdpath("state") .. "/onedark_style"

local function read_onedark_style()
    if vim.fn.filereadable(onedark_style_file) == 0 then
        return nil
    end

    local lines = vim.fn.readfile(onedark_style_file)
    return lines[1]
end

require("onedark").setup {
    -- Main options --
    style = read_onedark_style() or "darker", -- Default theme style. Choose between "dark", "darker", "cool", "deep", "warm", "warmer" and "light"
    transparent = false,                      -- Show/hide background
    term_colors = true,                       -- Change terminal color as per the selected theme style
    ending_tildes = false,                    -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false,             -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = "<leader>ts",                                                     -- keybind to toggle heme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = "italic,bold"
    code_style = {
        comments = "none",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none"
    },

    -- Lualine options --
    lualine = {
        transparent = false, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {},     -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true,     -- darker colors for diagnostic
        undercurl = true,  -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
    },
}

local function read_colorscheme()
    if vim.fn.filereadable(colorscheme_file) == 0 then
        return nil
    end

    local lines = vim.fn.readfile(colorscheme_file)
    return lines[1]
end

local function load_colorscheme()
    local colorscheme = read_colorscheme()
    if colorscheme and pcall(vim.cmd.colorscheme, colorscheme) then
        return
    end

    require("onedark").load()
end

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("TwentyColorscheme", { clear = true }),
    callback = function()
        local colorscheme = vim.g.colors_name
        if not colorscheme then
            return
        end

        pcall(vim.fn.mkdir, vim.fn.fnamemodify(colorscheme_file, ":h"), "p")
        pcall(vim.fn.writefile, { colorscheme }, colorscheme_file)

        if colorscheme == "onedark" and vim.g.onedark_config then
            pcall(vim.fn.writefile, { vim.g.onedark_config.style }, onedark_style_file)
        end
    end,
})

load_colorscheme()

-- treesitter
require("nvim-treesitter.config").setup {
    ensure_installed = {
        "python",
        "c",
        "cpp",
        "bash",
        "typst",
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
    },
    indent = {
        enable = true,
    },
}
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "<filetype>" },
    callback = function() vim.treesitter.start() end,
})

-- nvim-tree
local nvim_tree_api = require "nvim-tree.api"
require("nvim-tree").setup {
    filters = {
        dotfiles = false,
        git_ignored = true,
    },
    git = {
        enable = true,
    },
}
vim.keymap.set("n", "<C-e>", nvim_tree_api.tree.toggle, { desc = "Toggle file tree" })
vim.keymap.set("n", "<C-A-r>", nvim_tree_api.tree.reload, { desc = "Reload file tree" })

-- lazygit
vim.keymap.set("n", "<C-g>", ":LazyGit<CR>", { desc = "Open lazygit" })

-- telescope
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fs", telescope_builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
vim.keymap.set("n", "<leader>fr", telescope_builtin.lsp_references, { desc = "LSP references" })
vim.keymap.set("n", "<leader>fd", telescope_builtin.lsp_definitions, { desc = "LSP definitions" })
vim.keymap.set("n", "<leader>fi", telescope_builtin.lsp_implementations, { desc = "LSP implementations" })
vim.keymap.set("n", "<leader>fm", telescope_builtin.man_pages, { desc = "Man pages" })
vim.keymap.set("n", "<leader>ut", function()
    telescope_builtin.colorscheme({ enable_preview = true })
end, { desc = "Select colorscheme" })

local function load_telescope_fzf()
    local telescope = require("telescope")

    if pcall(telescope.load_extension, "fzf") then
        return
    end

    local fzf_lib = vim.api.nvim_get_runtime_file("lua/fzf_lib.lua", false)[1]
    if not fzf_lib then
        return
    end

    local plugin_dir = vim.fs.dirname(vim.fs.dirname(fzf_lib))
    local lib_path = plugin_dir .. "/build/libfzf.so"
    if vim.uv.fs_stat(lib_path) then
        return
    end

    vim.notify("Building telescope-fzf-native.nvim", vim.log.levels.INFO)
    vim.system({ "make" }, { cwd = plugin_dir }, function(result)
        vim.schedule(function()
            if result.code ~= 0 then
                vim.notify("Failed to build telescope-fzf-native.nvim", vim.log.levels.ERROR)
                return
            end

            pcall(telescope.load_extension, "fzf")
            vim.notify("telescope-fzf-native.nvim built", vim.log.levels.INFO)
        end)
    end)
end

load_telescope_fzf()

-- trouble
require("trouble").setup()
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Document symbols" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    { desc = "LSP definitions/references" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location list" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix list" })

-- gitsigns
require("gitsigns").setup {
    current_line_blame = false,
    on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local map = function(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        map("n", "]c", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(gitsigns.next_hunk)
            return "<Ignore>"
        end, { expr = true, desc = "Next git hunk" })
        map("n", "[c", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(gitsigns.prev_hunk)
            return "<Ignore>"
        end, { expr = true, desc = "Previous git hunk" })
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage git hunk" })
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset git hunk" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview git hunk" })
        map("n", "<leader>hb", gitsigns.blame_line, { desc = "Git blame line" })
    end,
}

-- flash
require("flash").setup()
vim.keymap.set({ "n", "x", "o" }, "s", function()
    require("flash").jump()
end, { desc = "Flash jump" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
    require("flash").treesitter()
end, { desc = "Flash treesitter" })
vim.keymap.set("o", "r", function()
    require("flash").remote()
end, { desc = "Flash remote" })
vim.keymap.set({ "o", "x" }, "R", function()
    require("flash").treesitter_search()
end, { desc = "Flash treesitter search" })

-- conform
require("conform").setup {
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "ruff_organize_imports" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        h = { "clang_format" },
        hpp = { "clang_format" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        typst = { "typstyle" },
        markdown = { "prettier" },
    },
    formatters = {
        clang_format = {
            prepend_args = {
                "--style=file:" .. vim.fn.stdpath("config") .. "/.clang-format",
            },
        },
    },
}
vim.keymap.set({ "n", "v" }, "<C-f>", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer or selection" })

-- cmake
require("cmake-tools").setup {
    cmake_command = "cmake",
    ctest_command = "ctest",
    cmake_use_preset = true,
    cmake_regenerate_on_save = true,
    cmake_generate_options = {
        "-DCMAKE_BUILD_TYPE=Debug",
        "-G 'Ninja Multi-Config'",
        "-DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE",
    },
    cmake_build_options = {
        "--parallel 6",
    },
    cmake_soft_link_compile_commands = false,
    cmake_build_directory = "build",
    cmake_kits_path = "~/.local/share/CMakeTools/cmake-tools-kits.json",
}

vim.keymap.set("n", "<f7>", ":CMakeBuild<CR>", { desc = "CMake build" })
vim.keymap.set("n", "<f5>", ":CMakeRun<CR>", { desc = "CMake run" })
vim.keymap.set("n", "<f6>", ":CMakeSelectLaunchTarget<CR>", { desc = "CMake select launch target" })

-- trim
require("trim").setup {
    ft_blocklist = {},
    patterns = {},
    trim_on_write = true,
    trim_trailing = true,
    trim_last_line = false,
    trim_first_line = true,
    highlight = false,
    highlight_bg = "#ff0000",
    highlight_ctermbg = "red",
    notifications = true,
}

-- comment
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment line" })
vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment selection" })

-- snippets
local luasnip = require("luasnip")
luasnip.setup { enable_autosnippets = true }
require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/snippets/" }

-- include guard snippet (always includes relative file path + filename)
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node

local function custom_guard_name()
    local file_path = vim.api.nvim_buf_get_name(0)
    local rel = vim.fn.fnamemodify(file_path, ":.")
    local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t"):upper()
    local norm = rel:gsub("[^%w]", "_"):upper()
    norm = norm:gsub("^_+", ""):gsub("_+$", "")
    return string.format("%s_%s_", project, norm)
end

local function include_guard_snippet()
    return s("guard", {
        f(function()
            return "#ifndef " .. custom_guard_name()
        end),
        t { "", "" },
        f(function()
            return "#define " .. custom_guard_name()
        end),
        t { "", "", "" },
        i(0),
        t { "", "", "" },
        f(function()
            return "#endif // " .. custom_guard_name()
        end),
    })
end

luasnip.add_snippets("cpp", { include_guard_snippet() })
luasnip.add_snippets("hpp", { include_guard_snippet() })
luasnip.add_snippets("c", { include_guard_snippet() })
luasnip.add_snippets("h", { include_guard_snippet() })

-- cmp
local cmp = require "cmp"
cmp.setup {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<C-Space>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping.abort(),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
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
            mode = "symbol", -- show only symbol annotations
            maxwidth = {
                -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                -- can also be a function to dynamically calculate max width such as
                -- menu = function() return math.floor(0.45 * vim.o.columns) end,
                menu = 50,            -- leading text (labelDetails)
                abbr = 50,            -- actual suggestion item
            },
            ellipsis_char = "...",    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
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

-- vimtex
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_compiler_latexmk = {
    aux_dir = ".texbuild",
    out_dir = ".",
}
require("config.tex").setup()

-- typst
vim.api.nvim_create_user_command("OpenPdf", function()
    local filepath = vim.api.nvim_buf_get_name(0)

    if filepath:match("%.typ$") then
        local pdf_path = filepath:gsub("%.typ$", ".pdf")
        vim.system({ "zathura", pdf_path })
    end
end, {})

-- nvim-surround
require("nvim-surround").setup {}

-- render-markdown
require("render-markdown").setup {}

-- md-pdf
local md_pdf = require("md-pdf")
md_pdf.setup {
    margins = "1.5cm",
    highlight = "tango",
    toc = true,
    title_page = false,
    preview_cmd = function()
        return "zathura"
    end,
    ignore_viewer_state = false,
    fonts = {
        main_font = "FiraCode Nerd Font",
        sans_font = "FiraCode Nerd Font",
        mono_font = "FiraCode Nerd Font Mono",
        math_font = "FiraCode Nerd Font",
    },
    pandoc_user_args = nil,
    output_path = "./",
    pdf_engine = "lualatex",
}
require("md-pdf.utils").warn = function() end

vim.keymap.set("n", "<leader>mp", function()
    md_pdf.convert_md_to_pdf()
end, { desc = "Markdown to PDF" })

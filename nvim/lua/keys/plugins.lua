require('keys.alias')
local set = vim.keymap.set

Nm("<C-t>", "<C-e>")

Nm("<C-A-r>", ":NvimTreeRefresh<CR>")
Nm("<C-e>", ":NvimTreeToggle<CR>")
Nm("<C-g>", ":LazyGit<CR>")

-- Comments

NmR("<C-/>", "gcc")
VmR("<C-/>", "gc")

-- Lsp keymaps
set("n", "gd", vim.lsp.buf.definition)
set("n", "K", vim.lsp.buf.hover)
set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
set("n", "<leader>vd", vim.diagnostic.open_float)
set("n", "[d", vim.diagnostic.goto_next)
set("n", "]d", vim.diagnostic.goto_prev)
set("n", "<leader>vca", vim.lsp.buf.code_action)
set("n", "<leader>vrr", vim.lsp.buf.references)
set("n", "<f2>", vim.lsp.buf.rename)

-- Cmake keymaps
Nm("<f7>", ":CMakeBuild<CR>")
Nm("<f5>", ":CMakeRun<CR>")
Nm("<f6>", ":CMakeSelectLaunchTarget<CR>")

-- Telescope keymaps
local telescope = require('telescope.builtin')
set("n", "<leader>ff", telescope.find_files)
set("n", "<leader>fg", telescope.live_grep)
set("n", "<leader>fb", telescope.buffers)
set("n", "<leader>fs", telescope.lsp_workspace_symbols)
set("n", "<leader>fr", telescope.lsp_references)
set("n", "<leader>fd", telescope.lsp_definitions)
set("n", "<leader>fi", telescope.lsp_implementations)
set("n", "<leader>fm", telescope.man_pages)

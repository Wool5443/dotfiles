vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return
{
    'nvim-tree/nvim-tree.lua',
    requires = {
        -- 'nvim-tree/nvim-web-devicons',
        'DaikyXendo/nvim-material-icon',
    },
    opts = {
        hijack_netrw = true,
        view = {
            width = 30,
            side = 'left',
        },
        filters = {
            dotfiles = false,
            git_ignored = false,
        },
        git = {
            enable = true,
        },
    },
}

return
{
    'nvim-treesitter/nvim-treesitter',
    opts = {
        ensure_installed = { 'c', 'cpp', 'lua', 'rust', 'bash', 'python' },
        sync_install = false,
        auto_install = true,
        indent = { enable = true };
        highlight = { enable = true };
    },
    run = ':TSUpdate',
}

return
{
    'nvim-treesitter/nvim-treesitter',
    opts = {
        ensure_installed = { 'cpp', 'lua', 'rust', 'bash', 'python' },
        sync_install = true,
        auto_install = true,
        indent = { enable = true };
        highlight = { enable = true };
    },
    run = ':TSUpdate',
}

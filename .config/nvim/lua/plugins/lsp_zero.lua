return
{
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
        -- LSP support
        'neovim/nvim-lspconfig',

        -- Autocompletetion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
    },

    config = function()
        require('lsp-zero').setup()
    end
}

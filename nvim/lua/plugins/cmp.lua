return
{
    'hrsh7th/nvim-cmp',
    requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
    },
    config = function()
        local cmp = require('cmp')
        cmp.setup({
            mapping = {
                ['<C-k>'] = cmp.mapping.select_prev_item(), -- Move to previous completion item
                ['<S-Tab>'] = cmp.mapping.select_prev_item(), -- Move to previous completion item
                ['<C-j>'] = cmp.mapping.select_next_item(), -- Move to next completion item
                ['<Tab>'] = cmp.mapping.select_next_item(), -- Move to next completion item
                -- ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion
                ['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Confirm selected completion
                ['<C-e>'] = cmp.mapping.abort(), -- Abort completion
            },
            sources = {
                { name = 'nvim_lsp' }, -- LSP source
                { name = 'buffer' },   -- Buffer completions
                { name = 'path' },     -- Path completions
                { name = 'luasnip' },  -- Snippet completions
            },
        })
    end
}

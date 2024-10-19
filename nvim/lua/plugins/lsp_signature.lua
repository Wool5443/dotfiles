return
{
    'ray-x/lsp_signature.nvim',
    config = function()
        require('lsp_signature').setup({
            bind = true,  -- This is mandatory, otherwise border config won't get registered.
            floating_window = true, -- Show signature in a floating window.
            hint_enable = true, -- Enable virtual text hints.
            handler_opts = {
                border = 'rounded'   -- 'single', 'double', 'rounded', 'solid', 'shadow'
            },
            -- You can tweak these parameters to adjust the behavior to your preference.
            max_height = 12,
            max_width = 80,
            hint_prefix = '🐼 ',  -- Can be any symbol you prefer
        })
    end
}

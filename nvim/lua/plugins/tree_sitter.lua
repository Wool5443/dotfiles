return
{
    'nvim-treesitter/nvim-treesitter',

    config = function()
        require'nvim-treesitter.configs'.setup {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                incremental_selection = true,
                indent = true,
            },
        }
    end,

    run = ':TSUpdate',
}

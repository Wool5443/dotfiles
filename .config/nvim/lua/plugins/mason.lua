return
{
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('mason-lspconfig').setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {}
            end
        }
        require('mason-lspconfig').setup {
            automatic_installation = true,
        }
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                }
            }
        })
    end
}

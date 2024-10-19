return
{
    'williamboman/mason.nvim',
	dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'nvim-lua/plenary.nvim',
	},
    servers = {
        'lua_ls',
        'rust_analyzer',
        'clangd',
    },
    config = function()
        require('lsp-zero').setup()
        require('mason').setup()
        require('mason-lspconfig').setup_handlers {
            function (server_name)
                require 'lspconfig' [server_name].setup {}
            end
        }
        require('mason-lspconfig').setup {
            automatic_installation = true,
        }
    end
}

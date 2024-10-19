local plugin_files = {
    'clangd',
    'cmp',
    'lazygit',
    'lspconfig',
    'lspkind',
    'lsp_zero',
    'mini_pairs',
    'nvim_tree',
    'plenary',
    'telescope',
    'tokyodark',
    'tree_sitter',
    'mason',
    'async_path',
    'clang_format',
    'cmake_tools',
    'nvim_dap',
    'nvim_dap_ui',
    'comment',
    'trim',
    'lualine',
    'lsp_signature',
    'auto-save',
}

local plugins = {}
for _, plugin in ipairs(plugin_files) do
  local ok, mod = pcall(require, 'plugins.' .. plugin)
  if ok then
    table.insert(plugins, mod)
  else
    print('Error loading plugin: ' .. plugin .. '\n' .. mod)
  end
end

return plugins

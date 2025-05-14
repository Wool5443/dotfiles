local plugin_files = {
    'themes.tokyodark',
    'themes.onedarkpro',
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
    'tree_sitter',
    'mason',
    'async_path',
    'cmake_tools',
    'comment',
    'trim',
    'lualine',
    'lsp_signature',
    'gen_tags',
    -- 'mini_animate',
    'todo_comments',
    'neogen',
    'cppguard',
    'mirror',
    'vimtex',
    'nvim_surround',
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

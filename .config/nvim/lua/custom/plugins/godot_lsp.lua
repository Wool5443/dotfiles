local client = vim.lsp.start_client {
    name = "godot-lsp",
    cmd = { "~/Apps/gdscript-lsp/target/release/godot-lsp" },
}

if not client then
    vim.notify 'the test client failed'
    return
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "gdscript",
    callback = function()
        vim.lsp.buf_attach_client(0, client)
    end,
})

return {}

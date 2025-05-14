local opt = vim.opt
local g = vim.g

opt.langmap='ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

g.mapleader = ' '
g.maplocalleader = '\\'

vim.diagnostic.config({
    virtual_text = true
})

opt.number = true
opt.relativenumber = true
opt.clipboard = 'unnamedplus'
opt.encoding = 'UTF-8'
opt.ruler = true
opt.wildmenu = true
opt.splitright = true
opt.splitbelow = true

opt.completeopt = 'menuone,noselect'

vim.cmd [[autocmd BufEnter * set fo-=c fo-=r fo-=o]]

vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("Twenty", { clear = true }),
    callback = function()
        -- Get buffer options
        local buftype = vim.bo.buftype
        local readonly = vim.bo.readonly
        local modifiable = vim.bo.modifiable

        -- Only save if the buffer is normal, not readonly, and modifiable
        if buftype == "" and not readonly and modifiable then
            vim.cmd("silent! w") -- Save current buffer
        end
    end,
})

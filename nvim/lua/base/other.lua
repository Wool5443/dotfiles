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

local map = vim.api.nvim_set_keymap

function Nm(key, command)
	map('n', key, command, {noremap = true})
end

function Im(key, command)
	map('i', key, command, {noremap = true})
end

function Vm(key, command)
	map('v', key, command, {noremap = true})
end

function Tm(key, command)
	map('t', key, command, {noremap = true})
end


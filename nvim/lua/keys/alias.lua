local map = vim.api.nvim_set_keymap

function Nm(key, command)
	map('n', key, command, {noremap = true})
end
function NmR(key, command)
	map('n', key, command, {noremap = false})
end

function Im(key, command)
	map('i', key, command, {noremap = true})
end
function ImR(key, command)
	map('i', key, command, {noremap = false})
end

function Vm(key, command)
	map('v', key, command, {noremap = true})
end
function VmR(key, command)
	map('v', key, command, {noremap = false})
end

function Tm(key, command)
	map('t', key, command, {noremap = true})
end
function TmR(key, command)
	map('t', key, command, {noremap = false})
end

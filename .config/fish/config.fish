if status is-interactive

set -g async_prompt_functions autopy
set -g async_prompt_inherit_variables all

zoxide init fish | source

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	command rm -f -- "$tmp"
end

alias n="nvim ."
alias l="ls -lah"
alias e="eza -lah"
alias ipy="ipython"

end


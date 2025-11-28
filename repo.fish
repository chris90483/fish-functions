# selecteer een repo uit ~/repos (met optioneel argument voor snelle selectie)
function repo
	set -l old_workdir $(pwd)
	cd ~/repos
	set -l target
	if test (count $argv) -gt 0
		set target (ls | fzf --query="$argv[1]" --select-1)
	else
		set target (ls | fzf)
	end

	if test -n "$target"
		cd "$target"
	else
		cd "$old_workdir"
	end
end


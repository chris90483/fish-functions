# geef alle custom fish functions en een beschrijving
function funcs
	set GRAY '\033[0;90m'	
	set NC '\033[0m' # No Color
	
	ls ~/.config/fish/functions/*.fish | while read -l f
		set name (basename $f .fish)
		set comment (awk '/^#/ {print; exit}' $f)
		printf "%s\t%s" $name
		echo -e "$GRAY $comment $NC"
	end | column -t -s \t
end


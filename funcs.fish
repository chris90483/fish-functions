# geef alle custom fish functions en een beschrijving
function funcs
	ls ~/.config/fish/functions/*.fish | while read -l f
		set name (basename $f .fish)
		set comment (awk '/^#/ {print; exit}' $f)
		printf "%s\t%s\n" $name $comment
	end | column -t -s \t
end


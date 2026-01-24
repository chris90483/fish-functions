# geef alle custom fish functions en een beschrijving
function funcs
	set -l GRAY '\033[0;90m'	
	set -l NC '\033[0m' # No Color
	set -l cols (tput cols)
	
	set -l max_name 0
	for f in ~/.config/fish/functions/*.fish
		set -l n (string length (basename $f .fish))
		test $n -gt $max_name; and set max_name $n
	end
	
	set -l comment_width (math $cols - $max_name - 5)
	
	for f in ~/.config/fish/functions/*.fish 
		set -l name (basename $f .fish)
		set -l comment (awk '/^#/ {print; exit}' $f)
		set -l comment_parts (printf "%s\n" $comment | fold -s -w $comment_width)
		
		printf "%s\t" $name
		echo -e "$GRAY$comment_parts[1]$NC"
		
		set -l blank (string repeat -n (string length $name) " ")
		set -l i 2
		for part in $comment_parts[2..-1]
			printf "%s\t" $blank
			echo -e "$GRAY  $part$NC"
		end
	end | column -t -s \t
end

# I'm an idiot.
function imanidiot
	set -l text "im an idiot"
	
	for char in (string split '' $text)
		set -l r (random 0 255)
		set -l g (random 0 255)
		set -l b (random 0 255)
		
		echo -en "\033[38;2;$r;$g;$b"
		echo -en "m" # gets their own since otherwise fish things its variable $bm above (which doesn't exist).
		echo -en "$char"
	end
	
	echo ""
end

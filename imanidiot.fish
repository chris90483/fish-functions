# I'm an idiot.
function imanidiot
	set -l text "im an idiot "

	if test (count $argv) -eq 0
		set repetitions 1
	else
		set repetitions $argv[1]
	end
	
	set curr_len 0
	for i in (seq 1 $repetitions)
		for char in (string split '' $text)
			set -l r (random 0 255)
			set -l g (random 0 255)
			set -l b (random 0 255)
			
			echo -en "\033[38;2;$r;$g;$b"
			echo -en "m" # gets their own since otherwise fish things its variable $bm above (which doesn't exist).
			echo -en "$char"
		end
	end
	
	echo ""
end

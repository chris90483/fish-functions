# start rider hier (zonder args), of vanuit een repo (zie repo functie)
function rider
	if test (count $argv) -gt 0
		repo $argv
	end
	~/Jetbrains_Rider/bin/rider . > /dev/null 2> /dev/null &
end

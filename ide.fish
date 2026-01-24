# start je IDE hier (zonder args), of vanuit een repo (zie repo functie)
function ide
	set -l IDE /usr/bin/codium
	if test (count $argv) -gt 0
		repo $argv
	end
	$IDE . > /dev/null 2> /dev/null &
end


# start je IDE hier (zonder args), of vanuit een repo (zie repo functie)
function ide
    if not set -q CONFIG_FISH_IDE
        echo "Missende configuratie:"
        echo "  set CONFIG_FISH_IDE /abspath/naar/jouw/ide" 
        echo "toevoegen aan ~/.config/fish/config.fish" 
        return 1 
    end
    
	if test (count $argv) -gt 0
		repo $argv
	end
	$CONFIG_FISH_IDE . > /dev/null 2> /dev/null &
	disown
end



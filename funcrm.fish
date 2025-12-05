# verwijder een functie
function funcrm
	set GREEN '\033[0;32m'
	set NC '\033[0m' # No Color
	
	if test (count $argv) -eq 0
		echo "Gebruik: funcrm <functienaam> (bijv. funcrm nav voor nav.fish)"
		return 1
	end

	set -l func_path "$HOME/.config/fish/functions/$argv[1].fish"

	if test -e "$func_path"
		rm "$func_path"
		echo "rm $func_path"
	else
		echo -e -n "$func_path bestaat niet. Gebruik"
		echo -e -n "$GREEN func $NC"
		echo -e "voor een lijst van functies"
		return 1
	end
end


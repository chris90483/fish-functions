# alias van ls | grep -i '<zoekterm>'
function lsg
	if test (count $argv) -eq 0
		echo "Gebruik: lsg '<zoekterm (whitespace toegestaan)>' (bijv. lsg mijn belangrijke document.txt)"
		return 1
	end
	
	ls | grep -i "$argv"
end

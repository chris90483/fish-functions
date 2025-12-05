# cd met pwd en uitgebreide ls in de nieuwe directory
function nav
	if test (count $argv) -gt 0
        	cd $argv
	end
	echo ""
	pwd
	printf '%*s' "$(tput cols)" '' | tr ' ' '='
	#set d $(pwd); echo "$d"; echo "$d" | tr '[:print:]' '='
	ls --group-directories-first
	echo ""
end

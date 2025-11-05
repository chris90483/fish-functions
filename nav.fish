# cd met pwd en ls in de nieuwe directory
function nav
	cd $argv
	echo ""
	pwd
	printf '%*s' "$(tput cols)" '' | tr ' ' '='
	#set d $(pwd); echo "$d"; echo "$d" | tr '[:print:]' '='
	ls
	echo ""
end

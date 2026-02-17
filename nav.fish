# cd met pwd ls in de nieuwe directory
function nav
	if test (count $argv) -gt 0
        	if not cd $argv
        	    cd (ls -d -- */ | fzf --query "$argv" --select-1)
    	    end
	end
	echo ""
	pwd
	printf '%*s' "$(tput cols)" '' | tr ' ' '='
	#set d $(pwd); echo "$d"; echo "$d" | tr '[:print:]' '='
	ls --group-directories-first
	echo ""
end

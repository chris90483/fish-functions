# Zoek een bestand en "start" deze (uitvoeren of openen in geschikt programma). Met optionele zoekparameter.
function start
    set selected ""
    set IDE_PATH /usr/share/codium/codium

    if test -n "$argv"
        set selected (find . -type f 2>/dev/null | fzf --query="$argv" --select-1)
    else
        set selected (find . -type f 2>/dev/null | fzf)
    end

    if test -n "$selected"
        if test -f "$selected" -a -x "$selected"
    	    ./$selected
        else if string match -q "$HOME/repos/*" "$(realpath $selected)"
		# file is inside ~/repos, always open those files in rider
        	
        	# we open the project directory, then the IDE can open the 
        	# file inside its instance later.
        	set -l project_dir (find_project_dir "$selected")
        	if test -n "$project_dir"
        		$IDE_PATH "$project_dir" 1>/dev/null 2>/dev/null &
        	end
        	
        	sleep 3
        	$IDE_PATH "$selected" 1>/dev/null 2>/dev/null &
	else
            xdg-open "$selected"
        end
    end
end



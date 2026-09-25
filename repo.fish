# selecteer een repo uit ~/repos (met optioneel argument voor snelle selectie)
function repo
	set -l old_workdir $(pwd)
	cd ~/repos
	set -l target
	set -l items (ls)
	if test (count $argv) -gt 0
	    set substr_matches (find_with_substr "$argv[1]" $items)
	    if test $(count $substr_matches) -eq "1"
	        set target $substr_matches[1]
	    else
		    set target (print_list $items | fzf --query="$argv[1]" --select-1)
	    end
	else
		set target (print_list $items | fzf)
	end

	if test -n "$target"
		cd "$target"
	else
		cd "$old_workdir"
	end
end

function find_with_substr
    # argv[1] is the query, argv[2..n] is the items
    for x in $argv[2..-1]
        # match prints if there's a match
        string match -- "*$argv[1]*" $x
    end
end

function print_list
    for x in $argv
        echo "$x"
    end
end


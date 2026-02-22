# alias van xdg-open
function start
    set selected ""

    if test -n "$argv"
        set selected (find . -type f 2>/dev/null | fzf --query="$argv" --select-1)
    else
        set selected (find . -type f 2>/dev/null | fzf)
    end

    if test -f "$selected"
    	xdg-open "$selected"
    end
end



# Hernoem een functie.
function funcrename
    set -l arg_count (count $argv)
    if not test "$arg_count" = "2"
        echo "Usage: funcrename <old> <new>"
        return 1
    end

    set -l source ~/.config/fish/functions/$argv[1].fish
    set -l dest ~/.config/fish/functions/$argv[2].fish
    if not test -f $source
        echo "$source bestaat niet."
        return 1
    end
    
    if test -f $dest
        echo "$dest bestaat al."
        return 1
    end
    
    mv $source $dest
    
   awk -v old="$argv[1]" -v new="$argv[2]" '$1 == "function" && $2 == old { sub(old, new) } 1' $dest > /tmp/__funcrename_temp.fish && mv /tmp/__funcrename_temp.fish $dest 
end

# bewerk een functie met gedit
function funcgedit
    if test (count $argv) -eq 0
        echo "Gebruik: funcgedit <functienaam> (bijv. funcgedit nav voor functie nav.fish)"
        return 1
    end

    set -l func_path "$HOME/.config/fish/functions/$argv[1].fish"    
    if not test -e "$func_path" 
        echo -e "#\nfunction $argv[1]\n\nend" > $func_path
    end
    
    gedit "$func_path"
    
    set -l saved_contents (cat "$func_path")    
    if test "$saved_contents" = "# function $argv[1]  end"
        rm "$func_path"
        echo "Lege functie $argv[1] is verwijderd."
    end
end

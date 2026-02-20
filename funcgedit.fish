# bewerk een functie met gedit
function funcgedit
    if test (count $argv) -eq 0
        echo "Gebruik: funcgedit <functienaam> (bijv. funcgedit nav voor functie nav.fish)"
        return 1
    end

    set -l func_path "$HOME/.config/fish/functions/$argv[1].fish"    
    if not test -e "$func_path" 
        echo -e "# Deze functie heeft nog geen beschrijving.\nfunction $argv[1]\n\nend" > $func_path
        set default_content_checksum (md5sum $func_path)
    else
        # function already existed, disable delete behavior.
        set default_content_checksum 0
    end
            
    gedit "$func_path"
    set -l saved_content_checksum (md5sum $func_path)
        
    if test "$saved_content_checksum" = "$default_content_checksum"
        rm "$func_path"
        echo "Template $argv[1] is verwijderd."
    end
end


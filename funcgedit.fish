# bewerk een functie met gedit
function funcgedit
    if test (count $argv) -eq 0
        echo "Gebruik: funcgedit <functienaam> (bijv. funcgedit nav voor functie nav.fish)"
        return 1
    end

    set -l func_path "$HOME/.config/fish/functions/$argv[1].fish"
    gedit "$func_path" &
end

# print de implementatie van de functie
function funcsource
    if test (count $argv) -eq 0
        echo "Gebruik: funcsource <functienaam> (bijv. funcsource nav voor functie nav.fish)"
        return 1
    end

    cat "$HOME/.config/fish/functions/$argv[1].fish"
end

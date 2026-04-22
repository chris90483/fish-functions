# print de implementatie van de costum fish functie
function funcsource
    if test (count $argv) -lt 1
        echo "Gebruik: funcsource <functienaam> (bijv. funcsource nav voor functie nav.fish)"
        return 1
    end
    
    set cmd bat
    if test (count $argv) -eq 2
        set cmd $argv[2]
    end
    
    eval $cmd "$HOME/.config/fish/functions/$argv[1].fish"
end

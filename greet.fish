# Greeter commands wanneer je de shell opent (roep deze functie aan in .config/fish/config.fish)
function greet
    fastfetch
    bind \t forward-char # tab key now always autocompletes 
    funcs
    echo
    now
end

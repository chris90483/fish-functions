# Escaleer naar root, custom fish functies blijven werken
function root
    sudo fish -C "set -a fish_function_path $HOME/.config/fish/functions; set HOME $HOME"
end

# Find files by name in cwd and children
function ff
    find . -name ".*" ! -name "." -prune -o -name "*$argv*" -print
end

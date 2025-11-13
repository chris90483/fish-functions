# fetch branches, selecteer er een en pull (met optioneel argument voor snelle selectie)
function branch
    if not git rev-parse --is-inside-work-tree > /dev/null 2>&1
        echo "$(pwd) is niet een git repository."
        return 1 # Stopt de functie met een foutcode
    end
    
    git fetch --prune --quiet

    set -l target_branch
    set -l branch_list (git branch -r | sed 's/ *origin\///' | grep -v 'HEAD')

    if test (count $argv) -gt 0
        set target_branch (printf "%s\n" $branch_list | fzf --query="$argv[1]" --select-1)
    else
        set target_branch (printf "%s\n" $branch_list | fzf)
    end

    if test -n "$target_branch"
        git checkout "$target_branch"
        git pull
    end
end

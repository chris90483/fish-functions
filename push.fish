# wizard voor git add, status, commit, push
function push
    set -l GREEN '\033[0;32m'
    set -l NC '\033[0m' # No Color

    set -l branch (git branch --show-current)
    echo "Branch: $branch"
    echo -e "$GREEN====== GIT PULL ======$NC"
    if not git pull
        echo "Nonzero exit status na git pull, script stopt."
        return 1
    end


    set -l branch_splitted (string split '-' -- $branch)    
    if test (count $branch_splitted) -ge 3
        set commit_branch_label (string join '-' $branch_splitted[1..2])
    else
        set commit_branch_label $branch
    end

    echo ""
    echo -e "$GREEN====== GIT STATUS ======$NC"    
    git status
    echo "'git add .' uitvoeren?"
    read -P "(Y/n): " run_git_add
    if test "$status" != "0"
        echo "Geannuleerd."
        return 1
    else if test -z "$run_git_add" -o "$run_git_add" = "y" -o "$run_git_add" = "Y"
        git add .
        echo ""
        echo -e "$GREEN====== GIT STATUS ======$NC"
        git status
    else if test "$run_git_add" = "n" -o "$run_git_add" = "N"
        echo "Overgeslagen."
    end
    
    echo ""
    echo -e "$GREEN====== GIT COMMIT ======$NC"    
    read -P "Commit message: " user_commit_message
    if test -z "$user_commit_message" -o "$status" != "0"
        echo "Geannuleerd."
        return 1
    end
    
    
    set -l full_commit_message "$commit_branch_label: $user_commit_message"
    echo "Commit wordt geschreven met message: '$full_commit_message'"
    if not git commit -m "'$full_commit_message'"
        echo "Nonzero exit status na commit, script stopt."
        return 1
    end
    
    echo ""
    echo -e "$GREEN====== GIT PUSH ======$NC"    
    git push
end

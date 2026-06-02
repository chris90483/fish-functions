# git diff tussen remote en local changes.
function diff
    set -l BLUE '\033[0;34m'
    set -l NC '\033[0m' # No Color

    if not git rev-parse --is-inside-work-tree > /dev/null 2>&1
        echo "$(pwd) is niet een git repository."
        return 1
    end

    git stash >/dev/null
    or return 1

    git pull >/dev/null
    or return 1


    set untracked_files (git ls-files --others --exclude-standard)
    set has_changes 0

    #################
    # TRACKED CHANGES
    if git stash pop >/dev/null 2>&1
        set has_changes 1

        # diffs (all but deleted files)
        echo -e -n "$BLUE"
        echo -e "Tracked: $NC"
        git diff --color=always @{upstream} --diff-filter=ACMRTUXB
        echo ""
    end
    
    ##############
    # DELETED FILES
    set deleted (git diff --name-only @{upstream} --diff-filter=D)

    if test (count $deleted) -gt 0
        set has_changes 1
        echo -e -n "$BLUE"
        echo -e "Verwijderd: $NC"
        git diff --summary @{upstream} --diff-filter=D
        echo ""
    end

    #####################
    # UNTRACKED ADDITIONS
    if test (count $untracked_files) -gt 0
        set has_changes 1
        for untracked_file in $untracked_files
            echo -e -n "$BLUE"
            echo -e "Nieuw untracked: $NC $untracked_file"
            cat $untracked_file
        end
    end

    if test $has_changes -eq 0
        echo "Er zijn geen lokale wijzigingen."
    end
end


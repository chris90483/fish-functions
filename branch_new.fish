# Maak een nieuwe branch aan volgens Oegema's conventies
function branch_new
    if not git rev-parse --is-inside-work-tree > /dev/null 2>&1
        echo "$(pwd) is geen git repository."
        return 1
    end

    if test (count $argv) -ne 1
        echo "Gebruik branch_new <issue nummer> (bijv. branch_new 1234)"  
        return 1
    end

    set -l categories "feature" "bugfix" "hotfix"
    set -l target_category (printf "%s\n" $categories | fzf)

    if test -z "$target_category"
        echo "geannuleerd."
        return 1
    end

    # Gebruik 'read' om interactief om een beschrijving te vragen
    set -l description
    read -P "Geef een beschrijving (in kebab-case): " description

    if test -z "$description"
        echo "geannuleerd."
        return 1
    end

    git fetch --prune
    git checkout master
    git pull
    set -l branch_name "$target_category/OGDPSD-$argv[1]-$description"
    git checkout -b "$branch_name"
end

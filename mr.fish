# Maak een GitLab Merge Request voor een Oegema issue
function mr
    set current_branch (git rev-parse --abbrev-ref HEAD)
    # 3 matches, type of issue, issue number and (optionally) a description.
    set matches (string match -r '.*/(OGDPSD-[0-9]+)(?:-(.*))?' -- $current_branch)
    if test (count $matches) -lt 2
        echo "Error: Branch name '$current_branch' does not match the format: [type]/OGDPSD-[NUMBER]-[description]"
        return 1
    end
    set issue_number $matches[2]
    set title_base ""
    if test (count $matches) -gt 2
        set title_base $matches[3]
    end
    set final_title ""
    if test -n "$title_base"
        set title_with_spaces (string replace -a -- '-' ' ' $title_base)
        set first_char (string sub -l 1 -- $title_with_spaces)
        set rest_of_string (string sub -s 2 -- $title_with_spaces)
        set final_title "$issue_number "(string upper $first_char)$rest_of_string
    else
        set final_title $issue_number
    end
    read -P "Proposed title: \"$final_title\". Press Enter to accept or provide a new title: " user_title
    if test -n "$user_title"
        set final_title "$user_title"
    end
    
    # branch selection
    echo "Please select the target branch:"
    echo "1) master"
    echo "2) staging"
    echo "3) production"
    read -P "Enter number (default: 1): " choice
    set target_branch "master" # Default
    switch $choice
        case 2
            set target_branch "staging"
        case 3
            set target_branch "production"
    end

    if test "$current_branch" = "$target_branch"
        echo "Error: Source branch ($current_branch) and target branch ($target_branch) cannot be the same."
        return 1
    end

    echo "Target branch set to: $target_branch"
    # To make sure the branch exists
    git push --set-upstream origin $current_branch
    
    echo "Creating Merge Request..."
    glab mr create --title "$final_title" --description "" --source-branch $current_branch --target-branch "$target_branch" --assignee "@me"
    
    set -l exit_code $status
    if test $exit_code -ne 0
        echo "Error: Failed to create Merge Request. 'glab' exited with status $exit_code."
        return $exit_code
    end
    echo "Successfully created Merge Request for issue $issue_number!"
    return 0
end

# Zoek de locatie van een [Desktop Entry]
function desktop_entry_find
    set -l YELLOW '\033[0;33m'
    set -l NC '\033[0m' # No Color

    if test (count $argv) -lt 1
        echo "usage: desktop_entry_find <name>"
        return 1
    end

    # normalize + filter query
    set -l raw_query (string lower $argv[1])
    set -l query (string replace -ra '[^a-z]' '' -- $raw_query)

    if test (string length $query) -lt (string length $raw_query)
        echo -e "$YELLOWwarning: non-alphabetic characters in query were ignored.$NC"
    end

    set -l dirs /usr/share/applications ~/.local/share/applications

    set has_results 0
    for dir in $dirs
        if not test -d $dir
            continue
        end

        for file in $dir/*.desktop
            if not test -f $file
                continue
            end

            # normalize + filter filename
            set -l raw_name (path basename $file | string lower)
            set -l name (string replace -ra '[^a-z]' '' -- $raw_name)

            set is_filename_printed 0
            if string match -q "*$query*" $name
                echo $file
                set has_results 1
                set is_filename_printed 1
            end

            # normalize + filter file contents (Name/Exec lines only)
            set -l content (grep -nE '^(Name|Exec)=' $file 2>/dev/null | string lower)

            if not string match -q "*$query*" $content
                continue
            end
                        
            if not test "$is_filename_printed" = "1"
                echo $file
                set $is_filename_printed 1                
            end
            
            for line in $content
                echo -e "$YELLOW$line$NC"
                set has_results 1
            end
        end
    end
    
    if test "$has_results" = "0"
        echo "Geen resultaten."
    end
end

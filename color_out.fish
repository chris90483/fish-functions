# eval $argv en print stdout in het grijs, stderr in het rood.
function color_out
    set -l GRAY '\033[0;90m'   # gray for stdout
    set -l RED '\033[0;31m'    # dark red for stderr
    set -l NC '\033[0m'        # reset
    
    set -l stdout_file (mktemp)
    set -l stderr_file (mktemp)
    eval $argv 1> $stdout_file 2> $stderr_file
    set -l status_code $status

    if test -s $stdout_file
        cat $stdout_file | while read line
            echo -e "$GRAY$line$NC"
        end
    end

    if test -s $stderr_file
        cat $stderr_file | while read line
            echo -e "$RED$line$NC"
        end
    end

    rm $stdout_file $stderr_file
    return $status_code
end

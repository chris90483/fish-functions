function get_dep_funcs
    set -l key $argv[1]
    set -l missing_deps (string split ";" -- $argv[2])
    
    for entry in $missing_deps
        set -l parts (string split \| -- $entry)
        set -l dep $parts[1]
        set -l func $parts[2]

        if test "$dep" = "$key"
            echo $func
        end
    end
end

# Geef een lijst met dependencies die in de functies worden gebruikt
function func_check_dependencies
    set -l RED "\033[0;31m"    
    set -l GREEN "\033[0;32m"
    set -l NC "\033[0m" # No Color
    # hack to prevent fish seeing the [ as an index operator
    set -l missing "$RED$(string unescape '\u005B')MISSEND]$NC"
    
    set builtins (builtin -n)
    set funcs (functions -n)
    set rows
    set missing_deps
    
    ##########################
    # DETERMINE DEPENDENCIES #
    ##########################
    
    echo -e -n "Dependencies aan het bepalen"
    set all_files ~/.config/fish/functions/*.fish ~/.config/fish/config.fish
    for f in $all_files
        echo -e -n "."
        set cmds (string match -r '^\s*([a-zA-Z0-9_-]+)' < $f)
        set splitted (string split '\S+' -- $cmds)

        set printed_file 0
        for untrimmed in $splitted
            set -l trimmed (string trim -- $untrimmed)
            
            if test -z $trimmed
                continue
            end
            
            if contains -- $trimmed $builtins $funcs
                continue
            end
            
            set -l exe_which (which -- $trimmed)
            set -l exe_source (dpkg -S $exe_which 2>/dev/null)
            
            if not test -z $exe_which
                if not test -z $exe_source
                    set rows $rows (string join -- \t $trimmed "$GREEN$exe_source$NC")
                else
                    set rows $rows (string join -- \t $trimmed "$GREEN$exe_which$NC")
                end
                
                continue
            end
        
            
            # Maybe there's a missing dependency, check it    
            if string match --quiet -- "--*" $trimmed
                # it's an option, not a command. Ignore it.
                continue
            end
            
            # Found a missing dependency
            set missing_deps $missing_deps "$trimmed|$f"
            set rows $rows (string join -- \t $trimmed $missing)
        end
    end
    
    
    ##########
    # OUTPUT #
    ##########
    set satisfied_count 0
    set missing_count 0
    
    echo -e "\n"
    set -l out_lines (printf "%s\n" $rows | column -t -s \t)
    set handled_keys
    for i in (seq (count $out_lines))
        set line $out_lines[$i]
        set key (string split \t -- $rows[$i])[1]
        
        if contains $key $handled_keys
            continue
        end
        
        echo -e -n $line
        if string match --quiet -- "*MISSEND*" $line
            set seen_funcs
            for funcpath in (get_dep_funcs $key (string join ";" $missing_deps))
                set -l base (basename $funcpath)
                if not set -l splitted (string split .fish $base)
                    continue
                end
                
                set -l func (echo "$splitted[1]")
                if contains "$func" $seen_funcs
                    continue
                end
                
                set seen_funcs $seen_funcs "$func"
            end
            
            set seen_config 0
            for seen_func in $seen_funcs
                if test "$seen_func" = "config"
                    set seen_config 1
                end
            end
            if test "$seen_config" = "1"
                set config_message "(staat in configuratiebestand \nfish shell, bekijk dit bestand met configgedit)."
            else
                set config_message ""
            end
            
            if test (count $seen_funcs) -gt 0
                echo -e -n "$RED Nodig voor: $(string join ', ' $seen_funcs) $config_message$NC"
            end
            
            set missing_count (math $missing_count + 1)
        else
            set satisfied_count (math $satisfied_count + 1)
        end
        
        set handled_keys $handled_keys $key
        echo ""
    end
    
    echo ""
    echo -e "$GREEN$satisfied_count$NC dependencies voldaan, $RED$missing_count$NC missende dependencies." 
end

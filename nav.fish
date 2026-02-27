# cd met pwd ls in de nieuwe directory
function nav
    set -l GRAY '\033[0;90m'
    set -l BLUE '\033[0;34m'
    set -l NC '\033[0m' # No Color
    set -l CYAN '\033[0;36m'

	if test (count $argv) -gt 0
        	if not cd $argv
        	    cd (ls -d -- */ | fzf --query "$argv" --select-1)
    	    end
	end
	echo ""

	set rootdev (df -P / | tail -1 | awk '{print $1}')
	set curdev  (df -P $PWD | tail -1 | awk '{print $1}')
	
	######################
	# wd
	if test "$curdev" = "$rootdev"
		pwd
	else
	set -l device (df -P $PWD | tail -1 | awk '{print $1}')
	set -l label (lsblk -no LABEL $device 2>/dev/null)
	set -l mountpoint (lsblk -no MOUNTPOINT $device 2>/dev/null)
	set -l drive_wd (string replace -r "^$mountpoint" "" (pwd))

	echo -e "$CYAN\133$label\135$NC$drive_wd"
	end
	
	######################
	# seperator
	set -l amtc (tput cols)
	set -l sep (string repeat -n $amtc "─")
	echo -e "$GRAY$sep$NC"
	
	######################
	# ls
	if test "$curdev" = "$rootdev"
		ls --group-directories-first	
	else
		set entries (ls --format single-column --group-directories-first)
		set columnized (printf "%s|\n" $entries | column -c (tput cols))
		
		set columnized_lines (string split \n $columnized)
		for line in $columnized_lines
			for part in (string split "|" "$line")
				set -l entry (string trim "$part")
				if test -d "$entry"
					echo -n -e "$BLUE$part$NC "
				else
					echo -n "$part "
				end
			end
			
			echo 
		end	
	end

	echo ""
end

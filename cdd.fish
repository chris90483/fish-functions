# (cd) naar een (d)rive (met --quiet voor geen echo)
function cdd
	set -l lines (lsblk -nrpo LABEL,NAME,SIZE,MOUNTPOINT)
	for line in $lines;
		set -l parts (string split ' ' $line)
		set -l pc (count $parts)

		set label      $parts[1]
		set name       $parts[2]
		set size       $parts[3]		
		set mountpoint $parts[4]

		if test -n "$mountpoint"
		    if test -z "$label"
		        continue
		    end

		    set entries $entries "$label !| $name !| $size !| $mountpoint"
		end
	end
	
	if test (count $argv) -ge 1
		set selected (printf "%s\n" $entries | column -t -s '!' | fzf --prompt="Selecteer drive: " --query="$argv[1]" --select-1)
	else
		set selected (printf "%s\n" $entries | column -t -s '!' | fzf --prompt="Selecteer drive: ")
	end
	
	if test -n "$selected"
		set -l parts (string split '|' $selected)
		set -l label (echo "$parts[1]" | string trim)
		set -l mountpoint (echo "$parts[4]" | string trim)
		
		cd $mountpoint
		if test (count $argv) -le 1
			nav .
		end	
	end 
end

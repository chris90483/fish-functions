# list drives met LABEL, NAME, SIZE, MOUNTPOINT
function lsd
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

		    set entries $entries "$label | $name | $size | $mountpoint"
		end
	end
	
	printf "%s\n" $entries | column -t -s '|'
end

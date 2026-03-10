# list drives met LABEL, NAME, SIZE, MOUNTPOINT
function lsd
	set -l lines (lsblk -nrpo LABEL,NAME,FSSIZE,FSUSED,FSUSE%,MOUNTPOINT)
	for line in $lines;
		set -l parts (string split ' ' $line)
		set -l pc (count $parts)

		set label      $parts[1]
		set name       $parts[2]
		set size       $parts[3]
		set used       $parts[4]
		set used_perc  $parts[5]		
		set mountpoint $parts[6]

		if test -n "$mountpoint"
		    if test -z "$label"
		        continue
		    end

		    set entries $entries "$label | $name | $used|/|$size|($used_perc) | $mountpoint"
		end
	end
	
	printf "%s\n" $entries | column -t -s '|'
end

# print huidige tijd, datum en weeknummer
function now
	date +'%H:%M:%S%n%A %d %B %Y'
	echo "Week $(date +%W)"
end

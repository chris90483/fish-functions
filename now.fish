# print huidige tijd, datum en weeknummer
function now
    set -l week_nr (date +%W)
	date +'%H:%M:%S%n%A %d %B %Y%n'
	
	echo "Weeknummer           : $(math $week_nr + 1)" # `date` starts at "week 0" which is not conventional in natural communication.
	echo "Dag van het jaar     : $(date +%j)"
	echo "Seconden sinds epoch : $(date +%s)"
end

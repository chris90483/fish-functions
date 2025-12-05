# print huidige tijd, datum en weeknummer
function now
	date +'%H:%M:%S%n%A %d %B %Y%n'
	echo "Weeknummer          : $(date +%W)"
	echo "Dag van het jaar    : $(date +%j)"
	echo "Seconden sinds epoch: $(date +%s)"
end

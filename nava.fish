# nav maar dan met een uitgebreidere ls
function nava
	if test (count $argv) -gt 0
        	cd $argv
	end
	echo ""
	pwd
	printf '%*s' "$(tput cols)" '' | tr ' ' '='
	# lat: long listing, all files, ordered by time
	ls -lat --group-directories-first
	echo ""
end


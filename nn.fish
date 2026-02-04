# nano -l <filename>
function nn
	if test -z $argv[1]:
		echo "usage: nn <filename>"
		return 1
	end
	
	nano -l $argv[1]
end

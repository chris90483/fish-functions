# Find files by name in cwd and children
function ff
	find . -type f -name "*$argv[1]*"
end

# Functie om de dichtstbijzijnde projectmap (met package.json of .sln) te vinden.
function find_project_dir
	set -l file_path ""
	if test (count $argv) -gt 0
		set file_path $argv[1]
	else
		set file_path (pwd)
	end

	set current_dir (dirname (realpath "$file_path"))
	set parent_dir (dirname "$current_dir")

	while not test "$current_dir" = "/"
		if test -e "$current_dir/package.json"; or find "$current_dir" -maxdepth 1 -name "*.sln" -print -quit | read -l
			echo "$current_dir"
			return 0
		end
		
		set current_dir "$parent_dir"
		set parent_dir (dirname "$parent_dir")
	end

	return 1
end

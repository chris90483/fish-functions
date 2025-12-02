# git pull, npm install en npm run dev (optioneel argument voor applicatieselecte). 
function start_web
	set -l old_location (pwd)
	if test (count $argv) -gt 0
		repo "$argv-web-app"
	end
		
	if not test -f package.json
		echo "Geen package.json in $(pwd)"
		cd $old_location
		return 1
	else
		echo "Working directory is $(pwd)"
	end

	echo "git pull"
	git pull
	echo "npm install"
	npm install
	echo "npm run dev"
	npm run dev
end

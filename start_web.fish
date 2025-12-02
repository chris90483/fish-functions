# start een frontend, met wat checks en setupjes ervoor (optionele parameter voor app, bijv hrm of fleet) 
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
	
	if test -f .env.development
		set -l commented_localhost_lines (grep -E '^#.*localhost:' .env.development)
		if test -n "$commented_localhost_lines"
			echo ".env.development check: er zijn nog localhost urls die uitgecomment staan:"
			for line in $commented_localhost_lines
				echo ">  $line"
			end
			
			gedit .env.development
		end
	end

	echo "git pull"
	git pull
	echo "npm install"
	npm install
	echo "npm run dev"
	npm run dev
end

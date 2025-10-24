function branch
	git fetch
	git checkout $(git branch -r | sed 's/ *origin\///' | fzf)
	git pull
end

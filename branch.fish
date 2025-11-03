function branch
	git fetch --prune
	git checkout $(git branch -r | sed 's/ *origin\///' | fzf)
	git pull
end

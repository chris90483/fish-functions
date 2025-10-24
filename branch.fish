function branch
	git checkout $(git branch -r | sed 's/ *origin\///' | fzf)
end

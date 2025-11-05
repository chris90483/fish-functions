# selecteer een repo uit ~/repos
function repo
	cd ~/repos
	cd "./$(ls | fzf)"
end


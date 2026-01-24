# Voeg een [Desktop Entry] toe aan ~/.local/share/applications
function make_desktop_entry
	set -l GRAY '\033[0;90m'	
	set -l NC '\033[0m' # No Color


	if test (count $argv) -ne 1
		echo "Gebruik make_desktop_entry <filename>"
		return 1
	end

	set -l file ~/.local/share/applications/$argv[1].desktop
	echo -n > $file	
	echo -e "[Desktop Entry]\nName=$argv[1]\nType=Application\nTerminal=false\nStartupNotify=true" >> $file
	
	
	#exec
	printf "Uitvoerbaar bestand: "
	set -l execPath (zenity --file-selection --title "Selecteer uitvoerbaar bestand")
	if test -z "$execPath"
		echo "geannuleerd."
		return 1
	end
	if not test -x "$execPath"
		echo ""
		printf "Het bestand "
		printf "%b" $GRAY; printf $execPath; printf "%b\n" $NC
		echo "Is niet uitvoerbaar. Uitvoerbaar maken met chmod +x ?"
		set -l make_exec
		read -P "(y/n): " make_exec
		if string match -iq 'y' $make_exec
			chmod +x "$execPath"
		else
			echo "Geannuleerd."
			return 1
		end
	end
	printf "%b" $GRAY; printf $execPath; printf "%b\n" $NC
	echo -e "Exec=$execPath" >> $file
	
	# categories
	printf "Categorie: "
	set -l all_categories
	for categoryfile in ~/.local/share/applications/*.desktop /usr/share/applications/*.desktop
		if test -f $categoryfile
			set -l categories_line (grep -m 1 '^Categories=' $categoryfile)
			if test -n "$categories_line"
				set -l categories (string sub -s 12 $categories_line)
				for cat in (string split ';' $categories)
					if test -n "$cat"
						if not contains $cat $all_categories
							set all_categories $all_categories $cat
						end
					end
				end
			end
		end
	end
	set -l chosen_category (printf "%s\n" $all_categories | fzf --prompt "Categorie: ")
	printf "%b" $GRAY; printf $chosen_category; printf "%b\n" $NC
	echo -e "Categories=$chosen_category;" >> $file
	
	#icon
	printf "Pictogram (optioneel): "
	set -l iconPath (zenity --file-selection --title "Selecteer pictogram (optioneel, annuleren toegestaan)")
	if test -f "$iconPath"
		printf "%b" $GRAY; printf $iconPath; printf "%b\n" $NC
		echo -e "Icon=$iconPath\n" >> $file
	end
	
	echo ""
	echo "Desktop entry aangemaakt in $file:"
	printf "%b" $GRAY; cat $file; printf "%b\n" $NC
	
	update-desktop-database ~/.local/share/applications
	echo "De ~/.local/share/applications desktop database is bijgewerkt."

end

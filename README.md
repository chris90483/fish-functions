# fish-functions
klonen naar `~/.config/fish/functions`. De `.fish` bestanden moeten in deze directory staan, niet in een child directory.

## config
Deze opslaan als `~/.config/fish/config.fish`
```
if status is-interactive
    # System info
    neofetch

    # always tab to autocomplete
    bind \t forward-char 
end
```
## lijst van functies, met beschrijving
```
funcs
```

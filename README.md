# fish-functions
klonen naar `~/.config/fish/functions`. De `.fish` bestanden moeten in deze directory staan, niet in een child directory.

## config
Deze opslaan als `~/.config/fish/config.fish`
```
if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch
    now
    bind \t forward-char
    
    set CONFIG_FISH_IDE rider # of vscodium, visual studio etc
end
```
## lijst van functies, met beschrijving
```
funcs
```

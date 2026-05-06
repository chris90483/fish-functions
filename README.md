# fish-functions
Gepersonaliseerde functies voor de fish shell.

## Installatie
- klonen naar `~/.config/fish/functions`. De `.fish` bestanden moeten in deze directory staan, niet in een child directory.
- Run `configgedit` en plak de config:
```
if status is-interactive
    ##################
    # greeter commands
    fastfetch
    now
    
    ##############################
    # always autocomplete with tab
    bind \t forward-char
    
    #######################
    # Environment variables
    
    # executable voor de \`ide\` functie.
    set CONFIG_FISH_IDE rider
    
    # pad om lokaal gebouwde NuGet packages in te zetten.
    set CONFIG_NUGET_LOCAL_PACKAGE_SOURCE ~/NugetLocalPackages
end
```

## lijst van functies, met beschrijving
```
funcs
```

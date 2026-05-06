# fish-functions
Gepersonaliseerde functies voor de fish shell.

## Installatie
- Deze repo klonen naar `~/.config/fish/functions`. De `.fish` bestanden moeten in deze directory staan, niet in een child directory.
- Stel de fish config in. Je kan de "Voorbeeld config" hieronder copy-pasten. Gebruik de volgende functie om de fish config te bewerken:
```
configgedit
```
- Check je dependencies met de onderstaande functie:
```
func_check_dependencies
```
- Als je een of meer dependencies mist zal deze checker je vertellen welke functies de dependency nodig hebben. Je kan andere functies wel gewoon gebruiken zonder de missende dependencies te installeren.

## Lijst van functies, met beschrijving
```
funcs
```
## Voorbeeld config
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
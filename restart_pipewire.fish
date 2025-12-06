# POTENTIAL FIX voor audio cracking probleem. systemctl --user restart voor pipewire, wireplumer en pipewire-pulse. meer info: funcsource restart_pipewire

# WAT IS DIT?
# Pipewire is een "Sound Server" op linux die als proxy dient tussen processen en de driver van de geluidskaart.
# Het herstarten van deze server lijkt de crackling noise op te lossen,
# deze is dus ook handig om te configureren in Startup Applications (cinnamon).

# GEBRUIK IK PIPEWIRE?
# chris@HAL9001 ~/Downloads [5]> pactl info | grep 'Server Name'
#
# Server Name: PulseAudio (on PipeWire 1.0.5)
# Als er niet 'on PipeWire' oid staat in de output heb je geen pipewire.
# ( Bovenstaand betekent overigens dat "PulseAudio" stiekem draait in wrapper van PipeWire ).
# ( Zie "WAT IS PIPEWIRE PULSE" hieronder. ).

# WAT IS WIREPLUMBER
# WirePlumber is de "session/policy manager" die PipeWire's API Wrapt met utility functions.
# nerd shit: https://pipewire.pages.freedesktop.org/wireplumber/design/understanding_session_management.html

# WAT IS PIPEWIRE-PULSE
# pipewire-pulse is de PulseAudio-compatibiliteitsserver van PipeWire.
# Het vervangt volledig de oude 'pulseaudio' daemon, maar biedt dezelfde API
# zodat programma's blijven werken alsof PulseAudio nog bestaat.
#
# Apps praten dus "tegen PulseAudio", maar PipeWire handelt het geluid echt af.
# Daarom toont 'pactl info' bijvoorbeeld: "PulseAudio (on PipeWire 1.0.5)".

function restart_pipewire    
    echo "systemctl --user restart pipewire"
    systemctl --user restart pipewire
    echo " - - done."
    
    echo "systemctl --user restart wireplumber"
    systemctl --user restart wireplumber
    echo " - - done."
    
    systemctl --user restart pipewire-pulse
    echo "systemctl --user restart pipewire-pulse"
    echo " - - done."
        
    # Check of Spotify draait (PID > 0)
    #set spotify_pid (pgrep spotify)

    #if test -n "$spotify_pid"
    #    echo "Spotify is running (PID: $spotify_pid). Recreating.."
    #    echo "pkill -f spotify"
    #    pkill -f spotify
    #    nohup spotify %U &
    #end
    
end

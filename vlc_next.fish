# Volgende track in vlc (je moet vlc al hebben draaien).
function vlc_next
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
end

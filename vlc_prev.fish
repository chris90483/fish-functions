# Vorige track in vlc (je moet vlc al hebben draaien).
function vlc_prev
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
end

# start rider vanuit een repo (zie repo functie)
function rider
  repo $argv
  ~/Jetbrains_Rider/bin/rider . > /dev/null 2> /dev/null &
end

#!/usr/bin/env bash

# You can call this script like this:
# $ ./brightnessControl.sh up
# $ ./brightnessControl.sh down

# Script inspired by these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

get_brightness () {
  brightnessctl get
}

send_notification () {
	DIR=`dirname "$0"`
	brightness=$(get_brightness)
	# Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
	#bar=$(seq -s "─" $(($volume/5)) | sed 's/[0-9]//g')
	bar=$(seq -s "─" $(($brightness/5)) | sed 's/[0-9]//g')
	
	if [ "$brightness" -lt "20" ]; then
        icon_name="$HOME/.local/share/dunst/brightness-20.png"
        notify-send "$volume""     " -i "$icon_name" --replace-id=555 -t 2000
    elif [ "$volume" -lt "40" ]; then
        icon_name="$HOME/.local/share/dunst/brightness-40.png"
    elif [ "$volume" -lt "60" ]; then
        icon_name="$HOME/.local/share/dunst/brightness-60.png"
    elif [ "$volume" -lt "80" ]; then
        icon_name="$HOME/.local/share/dunst/brightness-80.png"
    else
        icon_name="$HOME/.local/share/dunst/brightness-100.png"
	fi
	
	# Send the notification
	notify-send -i "$icon_name" "$brightness $bar" --replace-id=555
}

get-icon () {
	brightness=$(get_brightness)
	if [ "$brightness" = "0" ]; then
        icon_text="󰃝"
    elif [  "$brightness" -lt "10" ]; then
        icon_text="󰃞"
    elif [ "$brightness" -lt "30" ]; then
        icon_text="󰃟"
    elif [ "$brightness" -lt "70" ]; then
        icon_text="󰃠"
    else
        icon_text="󰃡"
	fi
}

case $1 in
  up)
    # increase the backlight by 5%
    brightnessctl set +5%
    send_notification
    ;;
  down)
    # decrease the backlight by 5%
    brightnessctl set 5%-
    send_notification
    ;;
  status)
	get-icon
	echo '{"text":"󰃠"}'
    ;;
esac

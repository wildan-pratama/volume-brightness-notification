#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

result="Unknown"

if pgrep -x "pulseaudio" > /dev/null; then
	result="pulse"
elif pgrep -x "pipewire" > /dev/null; then
	result="pipewire"
else
    notify-send "Sound server: Unknown (Neither PulseAudio nor PipeWire)"
    exit
fi

get_volume () {
    amixer -D "$result" get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

is_mute () {
    amixer -D "$result" get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}


send_notification () {
    DIR=`dirname "$0"`
    volume=`get_volume`
    
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
	#bar=$(seq -s "─" $(($volume/5)) | sed 's/[0-9]//g')
	bar=$(seq -s "─" $(($volume/5)) | sed 's/[0-9]//g')
	
    if [ "$volume" = "0" ]; then
        icon_name="$HOME/.local/share/dunst/volume-mute.png"
        notify-send "$volume""      " -i "$icon_name" -t 2000 -h int:value:"$volume" -h string:synchronous:"─" --replace-id=555
    elif [  "$volume" -lt "30" ]; then
        icon_name="$HOME/.local/share/dunst/volume-low.png"
        notify-send "$volume""     " -i "$icon_name" --replace-id=555 -t 2000
    elif [ "$volume" -lt "60" ]; then
        icon_name="$HOME/.local/share/dunst/volume-mid.png"
    else
        icon_name="$HOME/.local/share/dunst/volume-high.png"
	fi
	
	# Send the notification
	notify-send "$volume""     " -h string:synchronous:"$bar" -i "$icon_name" -t 2000 -h int:value:"$volume" --replace-id=555

}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer -D "$result" set Master on > /dev/null
	# Up the volume (+ 5%)
	amixer -D "$result" sset Master 5%+ > /dev/null
	#pactl set-sink-volume @DEFAULT_SINK@ +5%
	send_notification
	;;
    down)
	# Set the volume on (if it was muted)
	amixer -D "$result" set Master on > /dev/null
	# Down the volume (- 5%)
	amixer -D "$result" sset Master 5%- > /dev/null
	#pactl set-sink-volume @DEFAULT_SINK@ -5%
	send_notification
	;;
    mute)
	# Toggle mute
	amixer -D "$result" set Master 1+ toggle > /dev/null
	if is_mute ; then
	DIR=`dirname "$0"`
	notify-send -i "$HOME/.local/share/dunst/volume-mute.png" --replace-id=555 -u normal "Mute" -t 2000
	#notify-send -i "/usr/share/icons/Adwaita/32x32/status/audio-volume-muted-rtl-symbolic.symbolic.png" --replace-id=555 -u normal "Mute" -t 2000
	else
	    send_notification
	fi
    ;;
    mute-mic)
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
    mic_status=$(pactl list sources | grep -A 10 RUNNING | grep -A 10 "input" | grep "Mute:" | awk '{print $2}')
    if [[ "$mic_status" == "yes" ]]; then
    notify-send -i "$HOME/.local/share/dunst/microphone.png" --replace-id=555 -u normal "Mute" -t 2000
	else
	notify-send -i "$HOME/.local/share/dunst/microphone-mute.png" --replace-id=555 -u normal "Mute" -t 2000
	fi
	;;
esac

# volume-notification-dunst
This script enables dunst to send traditional volume notifications (screenshots below).
Inspired by https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a
This

# installation
The script requires the faba icon pack to be installed (otherwise icons won't be displayed) and relies 
on this script (https://github.com/vlevit/notify-send.sh/blob/master/notify-send.sh) to be placed in the
same directory. This patched notify-send.sh is necessary because by default notify-send doesn't allow replacing existing notifications. To use the script place it and notify-send.sh in the same folder and either type in a terminal 
/path/to/volume.sh up (or down or mute)
Or bind the desired functionality to your key combination of choice.
# screenshots
<a href="http://i.imgur.com/GKOliJ7.png">
  <img src="http://imgur.com/GKOliJ7l.png" />
</a>

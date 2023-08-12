# installation
Copy dunst folder to ~/.local/share/
```
cp -r dunst ~/.local/share
```
Install package need, if you are using pipeware you must install <b>pipewire-alsa pipewire-pulse</b>
```
#Debian, Ubuntu, Kali
apt-get install alsa-utils libnotify-bin

#Alpine
apk add alsa-utils libnotify

#Arch Linux
pacman -S alsa-utils libnotify

#CentOS
yum install alsa-utils libnotify

#Fedora
dnf install alsa-utils libnotify
```

# manual

```
/path/to/volume.sh up            	to increase the volume

/path/to/volume.sh down          	to decrease the volume

/path/to/volume.sh mute          	to mute the volume

/path/to/volume.sh mute-mc          to mute/unmute mic
```

Or bind the desired functionality to your key combination of choice.
# screenshots
![image](https://github.com/wildan-pratama/volume-notification/assets/84622086/594d973d-faaf-44d8-9882-91615c261134)

![image](https://github.com/wildan-pratama/volume-notification/assets/84622086/8202e80a-1cc8-4e20-9e1f-59cbb68554a1)

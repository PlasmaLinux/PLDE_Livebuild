#!/bin/bash

DEFAULT_BACKGROUNDS=/usr/share/backgrounds/plasma_dark.png
RUNFILE_DIR=~/.config/plasmalinux
RUNFILE="$RUNFILE_DIR"/.plasmalinux_backgrounds.run

#wait for xfdesktop to start
if [ `echo $USER` = "plasma" ];then
    TIME=5
else
    TIME=1
fi

sleep $TIME
until ps -C xfdesktop > /dev/null; do
    sleep $TIME
done


# exit if the script has been run before
[[ -f $RUNFILE ]] && exit 0


# get list of screens/monitors in an array (in case more that one monitor)
mapfile -t SCREENS < <(xfconf-query -c xfce4-desktop -lv | grep last-image | awk -F'/' '{print $3}')
mapfile -t MONITORS < <(xfconf-query -c xfce4-desktop -lv | grep last-image | awk -F'/' '{print $4}')

# cycle through array creating entries
for (( x=0; x <= ${#SCREENS[@]}; x++ ))
do
   xfconf-query -c xfce4-desktop -p /backdrop/${SCREENS[x]}/${MONITORS[x]}/workspace0/last-image -s ${DEFAULT_BACKGROUNDS}
done

# leave marker that script has been run
mkdir "${RUNFILE_DIR}"
touch $RUNFILE

exit 0


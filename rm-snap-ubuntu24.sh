#! /bin/bash

<<<<<<< HEAD
# GNU Public License 3.0
# Copyright (C) 2024  Gerardo Barcenas

echo "This is a test message."
=======
#Variables
snapListEmpty=false
userInput=""

printf "Welcome to rm-snap-ubuntu24 by Gerardo Barcenas (ver 0.1)"
printf "This script will attempt toremove the following: \nfirefox \nthunderbird \ngtk-common-themes \ngnome-42-2204 \nsnapd-desktop-integration \nsnap-store \nfirmware-updater \nbare \ncore22 \nsnapd \n\n"

# shellcheck disable=SC2162
read -p "Do you want to continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

sudo apt remove firefox gtk-common-themes gnome-42-2204 snapd-desktop-integration snap-store firmware-updater bare

sudo snap remove core22

sudo snap remove snapd

sudo systemctl stop snapd

sudo systemctl disable snapd

sudo systemctl mask snapd

sudo apt purge snapd -y

sudo apt-mark hold snapd

# shellcheck disable=SC2086
while [[ $snapListEmpty = true || $userInput = "exit" ]]
do
    echo "These are all the Snap Packages you still have installed:"
    snap list
    
    snapListEmpty=true
done



if [ $snapListEmpty = false ]
then
    echo "this works!"
fi

>>>>>>> a10670c (Inserted sudo rm commands)

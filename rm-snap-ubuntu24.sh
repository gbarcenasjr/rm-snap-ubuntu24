#! /bin/bash

# rm-snap-ubuntu24.sh  Copyright (C) 2024 Gerardo Barcenas
# This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
# This is free software, and you are welcome to redistribute it
# under certain conditions.



#Variables
confirm=""

printf "rm-snap-ubuntu24.sh Copyright (C) 2024 Gerardo Barcenas \n"
printf "This program comes with ABSOLUTELY NO WARRANTY. \n"
printf "This is free software, and you are welcome to redistribute it \n"
printf "under certain conditions. \n\n"

printf "Welcome to rm-snap-ubuntu24 by Gerardo Barcenas (ver 1.1) \n"
printf "This script will attempt to remove the following: \nfirefox \nthunderbird \ngtk-common-themes \ngnome-42-2204 \nsnapd-desktop-integration \nsnap-store \nfirmware-updater \nbare \ncore22 \nsnapd \n\n"

# shellcheck disable=SC2162
read -p "Do you want to continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

sudo snap remove firefox
sudo snap remove gtk-common-themes
sudo snap remove gnome-42-2204
sudo snap remove snapd-desktop-integration
sudo snap remove snap-store
sudo snap remove firmware-updater
sudo snap remove bare
sudo snap remove thunderbird
sudo snap remove core22
sudo snap remove snapd

confirm=""

# shellcheck disable=SC2086
while [[ $confirm == [gG] || $confirm == [gG][oO] ]]
do
    echo "These are all the Snap Packages you still have installed:"
    snap list
    
    # shellcheck disable=SC2162
    # shellcheck disable=SC2015
    read -p "Enter the name of any remaining Snap app or type Go: " confirm && [[ $confirm == [gG] || $confirm == [gG][oO] ]] || sudo snap remove $confirm
done

sudo systemctl stop snapd
sudo systemctl disable snapd
sudo systemctl mask snapd
sudo apt purge snapd -y
sudo apt-mark hold snapd

sudo rm -rf ~/snap
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd

# TODO: Fix so it can write the file to the directory!!!
# shellcheck disable=SC2024
sudo tee -a nosnap.pref > /etc/apt/preferences.d/ <<EOT
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOT

sudo apt install --install-suggests gnome-software

sudo apt update

echo "SNAP REMOVAL PROGRAM COMPLETED!"
# shellcheck disable=SC2162
read -p "(Optional) Would you like to install the Brave Browser (Deb Package)? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

# CLI instructions straight from the Brave Browser Install Linux site (https://brave.com/linux/)
sudo apt install curl

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser

# A seperate error code removal when trying to update the browser
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

#! /bin/bash

#Variables
confirm=""

printf "Welcome to rm-snap-ubuntu24 by Gerardo Barcenas (ver 0.1)"
printf "This script will attempt toremove the following: \nfirefox \nthunderbird \ngtk-common-themes \ngnome-42-2204 \nsnapd-desktop-integration \nsnap-store \nfirmware-updater \nbare \ncore22 \nsnapd \n\n"

# shellcheck disable=SC2162
read -p "Do you want to continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

sudo apt remove firefox gtk-common-themes gnome-42-2204 snapd-desktop-integration snap-store firmware-updater bare

sudo snap remove core22

sudo snap remove snapd

confirm=""

# shellcheck disable=SC2086
while [[ $confirm == [gG] || $confirm == [gG][oO] ]]
do
    echo "These are all the Snap Packages you still have installed:"
    snap list
    
    # shellcheck disable=SC2162
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

sudo tee -a nosnap.pref > /etc/apt/preferences.d <<EOT
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOT

sudo apt update

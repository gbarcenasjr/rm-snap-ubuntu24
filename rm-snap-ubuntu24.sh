#! /bin/bash

#Variables
confirm=""

printf "Welcome to rm-snap-ubuntu24 by Gerardo Barcenas (ver 1.0)"
printf "This script will attempt toremove the following: \nfirefox \nthunderbird \ngtk-common-themes \ngnome-42-2204 \nsnapd-desktop-integration \nsnap-store \nfirmware-updater \nbare \ncore22 \nsnapd \n\n"

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

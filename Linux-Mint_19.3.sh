#!/bin/bash
#   Description: Mainly changing adding and removing preferred packages and themes on Linux Mint 19.3 XFCE
#
#   Notes:
#       - Tested on Linux Mint 19.3 XFCE | Lenovo E595 Thinkpad | Ryzem 3700u | Integrated Vega 10 | Linux Mint 19.3 
#
#   Requirements:
#       - Internet      | This script is highly dependant on internet access, mostly to obtain packages...

# Check root user
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root" 
        exit 1
    fi

# Install...
echo Installing packages.....
# Applications:
#       - vscodium      |   text editor                     Used by preference
#       - megasync      |   cloud storage                   Used by preference
#       - mpv           |   Minimal CLI Video Player        Used by preference
#       - vlc           |   Multmedia Player                Used by preference
#       - git           |   GIT CLI Client                  Used by preference and required for script
#       - conky         |   Resource Monitor                Used by preference

    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

    if [[ $(dpkg --list | grep -wo megasync) = "megasync" ]]
    then
        echo Mega Sync is already installed...
    else
        wget https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync-xUbuntu_18.04_amd64.deb -P /tmp/
        dpkg -i /tmp/megasync-xUbuntu_18.04_amd64.deb
        rm /tmp/megasync-xUbuntu_18.04_amd64.deb
    fi

    if [[ $(dpkg --list | grep -wo codium) = "codium" ]]
    then
        echo VSCodium is already installed...
    else
        wget https://github.com/VSCodium/vscodium/releases/download/1.41.1/codium_1.41.1-1576787344_amd64.deb -P /tmp/
        dpkg -i /tmp/codium_1.41.1-1576787344_amd64.deb
        rm /tmp codium_1.41.1-1576787344_amd64.deb
    fi

    apt-get update -y
    apt-get install -f -y
    apt install -y mpv vlc spotify-client git

# Themes 
echo Preparing themes.....
# Window Manager:
#       - Arc-Dark          |   Dark theme                      to protect my eyes
    apt-get install -y arc-theme
    xfconf-query -c xsettings -p /Net/ThemeName -s "Arc-Dark"
    xfconf-query -c xfwm4 -p /general/theme -s "Arc-Darker"

# Conky:
#       - Resource Monitor  |
    apt-get install conky-all
    curl https://gitlab.com/Taghead/linux-install-scripts/raw/master/Files/Universal-Scripts/Conky.sh | bash

# Remove...
echo Removing packages.....
# Applications
#       - hexchat       |   IRC Chat Client                 Not used by preference
#       - transmission  |   BitTorrent Client               Not used by preference
#       - celluloid     |   Front-end for MPV               Not used by preference
#       - thunderbird   |   Mail client                     Not used by preference
#       - xed           |   Text editor                     Not used by preference
#       - mintwelcome   |   Welcome Screen                  Redundant IMO
#       - pix           |   Image Viewer                    Redundant xviewer installed by defaul
    apt-get autoremove -y --purge hexchat transmission-common transmission-gtk celluloid thunderbird xed mintwelcome pix

# Additional....
echo Additional changes.....
# Suspend on lid close while on AC
    xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/lid-action-on-ac -s 1


#
# Maintainence
    apt-get update -y
    apt-get upgrade -y

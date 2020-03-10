#!/bin/bash
#   Description: Mainly changing adding and removing preferred packages and themes on Linux Mint 19.3 XFCE
#
#   Notes:
#       - Tested on Linux Mint 19.3 XFCE | Lenovo E595 Thinkpad | Ryzem 3700u | Integrated Vega 10 | Linux Mint 19.3 
#
#   Requirements:
#       - Internet      | This script is highly dependant on internet access, mostly to obtain packages...

# Check root user
# Notes:
#       - This is required for the script to work optimally.
    if [ $EUID == 0 ] && [ "$1" == "--ignore" ]
    then
        echo " Ignoring root user status"
    elif [[ $EUID == 0 ]]
    then
        echo "The script runs optimally as a non root user."
        echo -e "\nThe follow will most likely not work:"
        echo -e "- Background Changes" 
        echo "To ignore this use --ignore"
        exit 1
    fi

# Install...
echo Installing packages.....
# Applications:
#       - build tools   |   Compiling Source                only needed to compile source code
#       - vscodium      |   text editor                     Used by preference
#       - megasync      |   cloud storage                   Used by preference
#       - mpv           |   Minimal CLI Video Player        Used by preference
#       - vlc           |   Multmedia Player                Used by preference
#       - git           |   GIT CLI Client                  Used by preference and required for script
#       - conky         |   Resource Monitor                Used by preference
#       - discord       |   Social Platform                 Used by preference
#       - eclipse-ide   |   IDE                             Needed sometimes
#       - gcloud-sdk    |   Google Cloud SDK                Needed sometimes
#       - pyenv         |   Python version manager          Used by preference
#       - jabba         |   Java Version Manager            Used by preference

    sudo apt install -y mpv vlc spotify-client git
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl libedit-dev

    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

    if [[ $(dpkg --list | grep -wo megasync) = "megasync" ]]
    then
        echo Mega Sync is already installed...
    else
        wget -N https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync-xUbuntu_18.04_amd64.deb -P /tmp/
        sudo dpkg -i /tmp/megasync-xUbuntu_18.04_amd64.deb
        rm /tmp/megasync-xUbuntu_18.04_amd64.deb
    fi

    if [[ $(dpkg --list | grep -wo codium) = "codium" ]]
    then
        echo VSCodium is already installed...
    else
        wget -N https://github.com/VSCodium/vscodium/releases/download/1.41.1/codium_1.41.1-1576787344_amd64.deb -P /tmp/
        sudo dpkg -i /tmp/codium_1.41.1-1576787344_amd64.deb
        rm /tmp/codium_1.41.1-1576787344_amd64.deb
    fi
    
    if [[ $(dpkg --list | grep -wo discord) = "discord" ]]
    then
        echo Discord is already installed...
    else
        wget -N https://dl.discordapp.net/apps/linux/0.0.9/discord-0.0.9.deb -P /tmp
        sudo dpkg -i /tmp/discord-0.0.9.deb
        rm /tmp/discord-0.0.9.deb
    fi

    if [ -d /usr/eclipse ]
    then
        echo Eclise-IDE is already installed...
    else 
        sudo apt install eclipse -y
        sudo rm /usr/bin/eclipse
        wget -N http://ftp.jaist.ac.jp/pub/eclipse/technology/epp/downloads/release/2019-03/R/eclipse-java-2019-03-R-linux-gtk-x86_64.tar.gz -P /tmp/
        sudo tar -zxvf /tmp/eclipse-java-2019-*-R-linux-gtk-x86_64.tar.gz -C /usr/
        sudo ln -s /usr/eclipse/eclipse /usr/bin/eclipse
        sudo printf '[Desktop Entry]\nEncoding=UTF-8\nName=Eclipse IDE\nComment=Eclipse IDE\nExec=/usr/bin/eclipse\nIcon=/usr/eclipse/icon.xpm\nTerminal=false\nType=Application\nCategories=Development;Programming\nStartupNotify=false\n'  >> /tmp/eclipse.desktop
        sudo mv /tmp/eclipse.desktop /usr/share/applications/eclipse.desktop
    fi
    
    if grep -Rwq ~/.bashrc -e '##pyenv';
    then
        echo .bashrc contains entry, assuming already installed PYENV
        curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    else
        curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
        printf '##pyenv\nexport PATH="/home/andrew/.pyenv/bin:$PATH"\neval "$(pyenv init -)"\neval "$(pyenv virtualenv-init -)"\n' >> ~/.bashrc
    fi

    if [ -d ~/.jabba ] 
    then
        echo Jabba already installed
    else
        curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh
    fi

    if [ -d ~/google-cloud-sdk ]
    then
    echo Assuming already installed google-cloud-sdk
    else
        wget -N https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-283.0.0-linux-x86_64.tar.gz  -P /tmp
        tar zxvf /tmp/google-cloud-sdk*.tar.gz -C ~
        ~/google-cloud-sdk/install.sh --usage-reporting true --rc-path ~/.bashrc --path-update true --command-completion true
    fi
    
    sudo apt-get update -y
    sudo apt-get install -f -y

# Themes 
echo Preparing themes.....
# Window Manager:
#       - Arc-Dark          |   Dark theme                      to protect my eyes
    sudo apt-get install -y arc-theme
    xfconf-query -c xsettings -p /Net/ThemeName -s "Arc-Dark"
    xfconf-query -c xfwm4 -p /general/theme -s "Arc-Darker"

# Conky:
#       - Resource Monitor  |
    sudo apt-get install conky-all
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
#       - pix           |   Image Viewer                    Redundant xviewer installed by default
#       - build tools   |   Compiling Source                only needed to compile source code
    sudo apt-get autoremove -y --purge hexchat transmission-common transmission-gtk celluloid thunderbird xed mintwelcome pix
    sudo apt-get autoremove -y --purge make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl libedit-dev

# Additional....
#Changing Desktop and Locakscreen Wallpaper
echo Applying Wallpaper.....
wget -N "https://images.hdqwalls.com/download/epic-explosion-70-$(xrandr | awk '$0 ~ "*" {print $1}').jpg" -P ~/Pictures/
connectedOutputs=$(xrandr | grep " connected" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
activeOutput=$(xrandr | grep -e " connected [^(]" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/") 
connected=$(echo $connectedOutputs | wc -w)
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -n -t string -s  ~/Pictures/epic-explosion-70-*.jpg
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorLVDS1/workspace0/last-image -n -t string -s  ~/Pictures/epic-explosion-70-*.jpg
for i in $(xfconf-query -c xfce4-desktop -p /backdrop -l|egrep -e "screen.*/monitor.*image-path$" -e "screen.*/monitor.*/last-image$"); do
    xfconf-query -c xfce4-desktop -p $i -n -t string -s ~/Pictures/epic-explosion-70-*.jpg 
    xfconf-query -c xfce4-desktop -p $i -s ~/Pictures/epic-explosion-70-*.jpg
done

echo Additional changes.....
# Suspend on lid close while on AC
    xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/lid-action-on-ac -s 1


#
# Maintainence
    sudo apt-get update -y
    sudo apt-get upgrade -y

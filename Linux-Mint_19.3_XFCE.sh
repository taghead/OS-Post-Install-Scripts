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
#       - nvm           |   Node version Manager            Used by preference
#       - Arc-Dark      |   Dark theme                      to protect my eyes
#       - Terraform     |   SaaS cloud managerment          Used by preferences
#       - awscli        |   AWS CLI                         Used by preferences

    sudo apt install -y mpv vlc spotify-client git arc-theme awscli
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
    
    if [ -d ~/.nvm ] 
    then
        echo NVM already installed
    else
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    fi

    if [ -d ~/google-cloud-sdk ]
    then
    echo Assuming already installed google-cloud-sdk
    else
        wget -N https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-283.0.0-linux-x86_64.tar.gz  -P /tmp
        tar zxvf /tmp/google-cloud-sdk*.tar.gz -C ~
        ~/google-cloud-sdk/install.sh --usage-reporting true --rc-path ~/.bashrc --path-update true --command-completion true
    fi
    
    if [ -f /usr/bin/terraform ]
    then
        echo Terraform installed
    else
        wget -N https://releases.hashicorp.com/terraform/0.12.23/terraform_0.12.23_linux_amd64.zip -P /tmp
        sudo unzip /tmp/terraform_0.12.23_linux_amd64.zip -d /usr/bin
    fi

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
    sudo apt-get autoremove -y --purge hexchat transmission-common transmission-gtk celluloid thunderbird xed mintwelcome pix
    
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

# Themes 
echo Preparing themes.....
# Window Manager
    xfconf-query -c xsettings -p /Net/ThemeName -s "Arc-Dark"
    xfconf-query -c xfwm4 -p /general/theme -s "Arc-Darker"

#
# Maintainence
    sudo apt-get autoclean -y
    sudo apt-get autoremove -y
    sudo apt-get clean -y
    sudo apt-get install -f -y
    sudo apt-get update -y
    sudo apt-get upgrade -y




#### NOTES TO SELF ####
#Run:
#curl https://gitlab.com/Taghead/linux-install-scripts/raw/master/Linux-Mint_19.3_XFCE.sh | bash
#
# pyenv install 2.7.16
# jabba install 1.13
# nvm install node

# Follow https://cloud.google.com/sdk/docs/initializing?hl=id

#Restart terminal and run...
#gcloud components install app-engine-python --quiet
#gcloud components install app-engine-python-extras --quiet
#gcloud components update
#Open eclipse and install though the marketplace:
# - Google cloud tools for Eclipse
# - AWS Toolkit for Eclipse (Help > INstall Enter https://aws.amazon.com/eclipse in the text box labeled “Work with” at the top of the dialog.)
# - Dynamic web module for Eclipse (Wild web developer?) (click right click on project -> properties -> project facets -> click on link then change dynamic web module )
# - Eclipse Java EE Developer Tools ( Eclipse Java Enterpise Developer Tools ?)
# - Eclipse Java Web Developer Tools ( Enide (Studio)? )
# - Eclipse Web Developer Tools ()
# - Eclipse JST Server Adapters


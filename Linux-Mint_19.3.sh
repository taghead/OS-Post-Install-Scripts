#   Description: Mainly changing preferred packages and themes on Linux Mint 19.3
#
#   Notes:
#       - Tested on Linux Mint 19.3
#
#   Requirements:
#       - Internet
# Install...
echo Installing packages.....
# Applications:
#       - vscodium              |   Preferred text editor
#       - megasync              |   Preferred cloud storage
#       - mpv                   |   Minimal CLI Video Player
#       - vlc                   |   Multmedia Player
#       - git                   |   Used for git clone and projects
#       - conky                 |   Resource Monitor Configuration

    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

    wget https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync-xUbuntu_18.04_amd64.deb -P /tmp/
    dpkg -i /tmp/megasync-xUbuntu_18.04_amd64.deb
    rm /tmp/megasync-xUbuntu_18.04_amd64.deb

    wget https://github.com/VSCodium/vscodium/releases/download/1.41.1/codium_1.41.1-1576787344_amd64.deb -P /tmp/
    dpkg -i /tmp/codium_1.41.1-1576787344_amd64.deb
    rm /tmp codium_1.41.1-1576787344_amd64.deb

    apt-get update -y
    apt-get install -f -y
    apt install -y mpv vlc spotify-client git conky-all

# Themes 
echo Preparing themes.....
# Window Manager:
#       - Arc-Dark
    apt-get install -y arc-theme
    xfconf-query -c xsettings -p /Net/ThemeName -s "Arc-Dark"
    xfconf-query -c xfwm4 -p /general/theme -s "Arc-Darker"

# Remove...
echo Removing packages.....
# Applications
#       - hexchat       |   Not used by preference
#       - transmission  |   Not used by preference
#       - celluloid     |   Not used by preference
#       - thunderbird   |   Not used by preference
    apt-get autoremove -y --purge hexchat transmission-common transmission-gtk celluloid thunderbird

# Additional....
# Maintainence
    apt-get update -y
    apt-get upgrade -y

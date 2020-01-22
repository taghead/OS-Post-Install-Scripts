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
#       - vscodium           |   Preferred text editor
    apt install -y 

    wget https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync-xUbuntu_18.04_amd64.deb -P /tmp/
    dpkg -i /tmp/megasync-xUbuntu_18.04_amd64.deb
    rm /tmp/megasync-xUbuntu_18.04_amd64.deb
    apt-get install -f -y


    wget https://github.com/VSCodium/vscodium/releases/download/1.41.1/codium_1.41.1-1576787344_amd64.deb -P /tmp/
    dpkg -i /tmp/codium_1.41.1-1576787344_amd64.deb
    rm /tmp codium_1.41.1-1576787344_amd64.deb

# Themes 
echo Preparing themes.....
# Window Manager:
#       - Arc-Dark
    apt install -y arc-theme

# Remove...
echo Removing packages.....
# Applications
#       - hexchat       |   Not used by preference
#       - transmission  |   Not used by preference
#       - celluloid     |   Not used by preference
#       - thunderbird   |   Not used by preference
    apt autoremove -y --purge hexchat transmission-common transmission-gtk celluloid thunderbird

# Additional....

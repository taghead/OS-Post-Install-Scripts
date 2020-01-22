#   Notes:
#       - Tested on ubuntu server 19.10
#
#   Requirements:
#       - Internet (Use nmtui to configure network?)

# Install...
echo Installing packages.....
# Applications:
#       - Openbox           |   Used for session
#       - obconf            |   Configure openbox. (Use to change appearance)
#       - python            |   Required for openbox rightclick menu
#       - lxappearance      |   Configure qt5 windows appearance

    apt install openbox obconf python lxappearance

# Themes 
echo Preparing themes.....
# obconf:
#       - Triste-Violet
# lxappearance:
#       - Arc-Dark
    git clone https://github.com/addy-dclxvi/openbox-theme-collections ~/.themes
    apt install arc-theme

# Remove...
echo Removing packages.....
# Applications
#       - ubuntu-session    |   Replaced by openbox
#       - snapd             |   Preference, apt is paramount.
    apt autoremove --purge ubuntu-session snapd

# Additional....
# Fixes:
echo Running Fixes.....
#       - Unable to boot offline    | Disable and Mask systemd-networkd-wait-online.service
#       - Long boot time            | Remove cloud-init
#

# Unable to boot offline    | Disable and Mask systemd-networkd-wait-online.service
    if [ -f /etc/systemd/system/systemd-networkd-wait-online.service ]
    then
        systemctl disable systemd-networkd-wait-online.service 
        systemctl mask systemd-networkd-wait-online.service 
    fi

# Long boot time            | Remove cloud-init
    if [ -d /etc/cloud ]
    then
        echo 'datasource_list: [ None ]' | sudo -s tee /etc/cloud/cloud.cfg.d/90_dpkg.cfg
        apt-get purge cloud-init
        su rm -rf /etc/cloud/; sudo rm -rf /var/lib/cloud/
        rm -rf /etc/cloud/; rm -rf /var/lib/cloud/
    fi
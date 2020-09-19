#!/bin/bash
#   Description: This is a bare metal install of openbox. There will be issues to be expected that will need to tackled at a per user basis.
#   
#   Issues expected:
#       - Fn key shortcut issues (Volume up, brighness...)
#
#   Disadvantages:
#       - Openbox does not fully support window snapping
#
#   Notes:
#       - Tested on ubuntu server 19.10
#       - +REP https://github.com/addy-dclxvi/openbox-theme-collections for the amazing obconf themes.
#       - This setup installs openbox and removes the ubuntu session.
#       - To apply the downloaded themes use obconf and lxappearance.
#       - By preference I do the following
#           - Remove snapd
#           - Disable systemd-networkd-wait-online.service 
#           - Unistall cloud-init
#           - Install lxsesson as my default session manager.
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
#       - lxsession         |   Used for default session manager

    apt install -y openbox obconf python lxappearance lxsession

# Themes 
echo Preparing themes.....
# obconf:
#       - Triste-Violet
# lxappearance:
#       - Arc-Dark
    git clone https://github.com/addy-dclxvi/openbox-theme-collections ~/.themes
    apt install -y arc-theme

# Remove...
echo Removing packages.....
# Applications
#       - ubuntu-session    |   Replaced by openbox
#       - snapd             |   Preference, apt is paramount.
    apt autoremove -y --purge ubuntu-session snapd

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

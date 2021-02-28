# Linux Install Scripts
A collection of personal post linux installation scripts for various Linux distributions.

## Linux Mint
- Linux Mint 19.3
    - Mainly changing adding and removing preferred packages and themes on Linux Mint 19.3
    - Installs `arc-theme` and applies *arc-darker* to the __window manager__ and *arc-dark* to __appearance__.
    - Removes `hexchat`, `transmission`. `celluloid`. `thunderbird`, `xed`, `mintwelcome` and `pix`.
    - One liner install ```curl https://raw.githubusercontent.com/taghead/OS-Post-Install-Scripts/master/Linux/Bash/Linux-Mint_19.3_XFCE.sh | bash```
    
## Ubuntu Server
- Ubuntu Server 19.10
    - This is a bare metal install of openbox. There will be issues to be expected that will need to tackled at a per user basis.
    - Installs `Openbox`, `obconf`, `python`, `lxappearance` and `lxsession`.
    - Manually apply *Triste-Violet* in __obconf__ and *Arc-Dark* in __lxappearance__.
    - Removes `ubuntu-session` and `snapd`.
    - Fixed issues:
        - Unable to boot offline. Disable and Mask systemd-networkd-wait-online.service.
        - Long boot time. Remove cloud-init.
    - One liner install ```curl https://raw.githubusercontent.com/taghead/OS-Post-Install-Scripts/master/Linux/Bash/Ubuntu-Server_19.10.sh | sudo bash```

### WIP
- Linux
    - Bash
        -  Debian 10 MongoDB    https://raw.githubusercontent.com/taghead/OS-Post-Install-Scripts/master/Linux/Bash/Server_Mongo_DB-Debian_10.sh
    - Ansible
        - Stand MongoDB-4.2     https://raw.githubusercontent.com/taghead/OS-Post-Install-Scripts/master/Linux/Ansible/MongoDB-4.2.yml
        - Add Samba Mount       https://raw.githubusercontent.com/taghead/OS-Post-Install-Scripts/master/Linux/Ansible/AddSambaMount.yml

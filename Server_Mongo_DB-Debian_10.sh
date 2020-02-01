#!/bin/bash
#   Description: Dedicated MongoDB server installed on Debian 10 Buster
#
#   Notes:
#       - Tested on Proxmox VM Debian 10 
#
#   Requirements:
#       - Internet      | This script is highly dependant on internet access, mostly to obtain packages...

# Install...
echo Installing packages.....
# Applications:
#       - mongodb-org*      |   Database                     Required

#!/bin/bash

#Install MongoDB 4.2.3
apt-get install -y gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
apt-get update -y
apt-get install -y mongodb-org=4.2.3 mongodb-org-server=4.2.3 mongodb-org-shell=4.2.3 mongodb-org-mongos=4.2.3 mongodb-org-tools=4.2.3

#Prevent update for the following
echo "mongodb-org hold" | dpkg --set-selections
echo "mongodb-org-server hold" | dpkg --set-selections
echo "mongodb-org-shell hold" | dpkg --set-selections
echo "mongodb-org-mongos hold" | dpkg --set-selections
echo "mongodb-org-tools hold" | dpkg --set-selections


#Preparing the mongodb server.
read -p "\nEnter Admin User: "  userAdmin
read -s -p "\nEnter Admin Password: "  passAdmin
read -p "\nEnter Database User: "  userDatabase
read -s -p "\nEnter Password: "  passDatabase
read -p "\nEnter Database Name: "  userDatabase

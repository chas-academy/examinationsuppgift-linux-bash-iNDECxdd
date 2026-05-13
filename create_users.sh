#!/bin/bash

# get user id of curent user
user_id=$(id -u) 

# echo $user_id

# checks if user id is not 0
if [[ $user_id -ne 0 ]]; then
    echo "Need to run as root"
    exit 1
fi

echo "is root"
mkdir /log/ # skapar ifall finns

echo ""

# loop vi igen arguemt som gavs
for usr in $@; do
    echo "creating user $usr"
    adduser --disabled-password --comment "" $usr 
    echo creating Documents, Download and Work dirs
    mkdir -p "/home/$usr/Documents" "/home/$usr/Downloads" "/home/$usr/Work"
    echo "adding user to user log file" 
    echo "$usr" >> /log/users
    echo "Välkommen $usr" > /home/$usr/welcome.txt
    # echo " " >> /home/$usr/welcome.txt
    # cat /log/users >> /home/$usr/welcome.txt
    echo "handeling user perms"
    chown $usr /home/$usr/* && chgrp $usr /home/$usr/* && chmod 700 /home/$usr/* 
    echo $(ls -lR /home/$usr/)
    echo ""
    echo ""
done


for usr in $@; do
cat /log/users >> /home/$usr/welcome.txt
cat /home/$usr/welcome.txt
echo ""
echo ""
done

#!/bin/bash

user_id=$(id -u) 

# echo $user_id

if [[ $user_id -ne 0 ]]; then
    echo "Need to run as root"
    exit 1
fi

mkdir /log/

for user in $@; do
    adduser $user 
    mkdir -p "/home/$user/Documents" "/home/$user/Downloads" "/home/$user/Work"
    echo "$user" >> /log/users
    echo "Välkommen $user" > /home/$user/welcome.txt
    # echo " " >> /home/$user/welcome.txt
    # cat /log/users >> /home/$user/welcome.txt
    
    chown $user /home/$user/* && chgrp $user /home/$user/* && chmod 700 /home/$user/*
done

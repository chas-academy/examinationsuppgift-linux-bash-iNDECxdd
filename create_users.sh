#!/bin/bash

#Lägger till mappar i skel som nya användare får automatiskt
sudo /etc/skel/Downloads
sudo /etc/skel/Documents
sudo /etc/skel/Work

#Skapar nya användare, for-loop används för att gå igenom alla parametrar i $@
for användarnamn in "$@"
do 
    sudo useradd "$användarnamn"
done

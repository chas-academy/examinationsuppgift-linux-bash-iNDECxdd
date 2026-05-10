#!/bin/bash

#Lägger till mappar i skel som nya användare får automatiskt
sudo mkdir /etc/skel/Downloads
sudo mkdir /etc/skel/Documents
sudo mkdir /etc/skel/Work

#Skapar nya användare, for-loop används för att gå igenom alla parametrar i $@
for användarnamn in "$@"
do 
    sudo useradd "$användarnamn"
done

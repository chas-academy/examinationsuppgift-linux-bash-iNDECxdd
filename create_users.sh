#!/bin/bash

#Lägger till mappar i skel som nya användare får automatiskt
Downloads = "/etc/skel/Downloads"
Documents = "/etc/skel/Documents"
Work = "/etc/skel/Work"

if test ! -d "$Downloads"
then
    sudo mkdir /etc/skel/Downloads
fi

if test ! -d "$Documents"
then
    sudo mkdir /etc/skel/Documents
fi

if test ! -d "$Work"
then
    sudo mkdir /etc/skel/Work
fi

#Skapar nya användare, for-loop används för att gå igenom alla parametrar i $@
for användarnamn in "$@"
do 
    sudo useradd -m "$användarnamn"
done

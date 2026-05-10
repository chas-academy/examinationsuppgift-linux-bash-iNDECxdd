#!/bin/bash

#Kollar om användaren är root eller inte

if ["$EUID" -ne 0 ];
then
    echo "Du har ej behörighet att köra detta script"
    exit 1
fi

#Skapar nya användare, for-loop används för att gå igenom alla parametrar i $@
for användarnamn in "$@"
do 
    sudo useradd -m "$användarnamn"
done

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


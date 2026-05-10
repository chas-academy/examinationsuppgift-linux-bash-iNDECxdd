#!/bin/bash

#Kollar om användaren är root eller inte

if [ "$EUID" -ne 0 ];
then
    echo "Du har ej behörighet att köra detta script"
    exit 1
fi

#Skapar nya användare och mappar, for-loop används för att gå igenom alla parametrar i $@
for username in "$@"
do 
    useradd -m "$username"

    homedir="/home/$username"
    welcome="$homedir/welcome.txt"

    mkdir -p "$homedir/Downloads"
    mkdir -p "$homedir/Documents"
    mkdir -p "$homedir/Work"

    chown -R "$username:$username" "$homedir"
done

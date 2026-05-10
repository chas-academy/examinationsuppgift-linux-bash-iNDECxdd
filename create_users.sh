#!/bin/bash

#Kollar om användaren är root eller inte
if [ "$EUID" -ne 0 ];
then
    echo "Du har ej behörighet att köra detta script"
    exit 1
fi

if [ "$#" -eq 0 ]; then
    echo "Vänligen ange användarnamn"
    exit 1
fi

#Skapar nya användare och mappar, for-loop används för att gå igenom alla parametrar i $@
for username in "$@"
do 
    #Skapar användare med en hemkatalog
    useradd -m "$username"
    homedir="/home/$username"
    welcome="$homedir/welcome.txt"

    #Skapar mappar
    mkdir -p "$homedir/Downloads"
    mkdir -p "$homedir/Documents"
    mkdir -p "$homedir/Work"

    #Ger ägande över hemkatalogen till användaren
    chown -R "$username:$username" "$homedir"

    #Bara användaren kommer åt hemkatalogen
    chmod -R 700 "$homedir"

    #Lägger till användaren till välkomstfilen
    echo "Välkommen $username" >"$welcome"
    echo "Övriga användare:" >> "$welcome"

    #Ändrar rättigheter så alla kan läsa filen
    chmod 644 "$welcome"

done

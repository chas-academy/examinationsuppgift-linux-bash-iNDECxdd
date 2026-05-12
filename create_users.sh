#!/bin/bash

#Kollar om användaren är root eller inte
if [ "$EUID" -ne 0 ]; then
    echo "Du är inte root"
    exit 1
fi

#Skapar nya användare och mappar, for-loop används för att gå igenom alla parametrar i $@
for USERNAME in "$@"; do 
    #Skapar användare med en hemkatalog
    echo "Skapar användare och hemkatalog"
    useradd -m "$USERNAME"
    HOME_DIRECTORY="/home/$USERNAME"
    WELCOME="$HOME_DIRECTORY/welcome.txt"

    #Skapar mappar i hemkatalogen
    mkdir -p "$HOME_DIRECTORY/Downloads"
    mkdir -p "$HOME_DIRECTORY/Documents"
    mkdir -p "$HOME_DIRECTORY/Work"

    #Ger ägande över hemkatalogen till användaren
    chown -R "$USERNAME:$USERNAME" "$HOME_DIRECTORY"

    #Bara användaren kommer åt hemkatalogen
    chmod -R 700 "$HOME_DIRECTORY"

    #Skapar välkomstfilen, for-loopen lägger till en lista över övriga användare från inparametrarna "$@", exklusive den aktuella användaren
    echo "Välkommen $USERNAME" > "$WELCOME"
    echo "" >> "$WELCOME"
    echo "Övriga användare:" >> "$WELCOME"
    for user in "$@"; do
        if [ "$user" != "$USERNAME" ]; then
        echo "$user" >> "$WELCOME"
        fi
    done

    #Ändrar rättigheter så alla kan läsa filen men bara ägaren kan ändra
    chmod 644 "$WELCOME"

done

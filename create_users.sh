#!/bin/bash

#Kollar om användaren är root eller inte
if [ "$EUID" -ne 0 ];
then
    echo "Du har ej behörighet att köra detta script"
    exit 1
fi

#Skapar nya användare och mappar, for-loop används för att gå igenom alla parametrar i $@
for USERNAME in "$@"
do 
    #Skapar användare med en hemkatalog
    useradd -m "$USERNAME"
    HOME="/home/$USERNAME"
    WELCOME="$HOME/welcome.txt"

    #Skapar mappar i hemkatalogen
    mkdir -p "$HOME/Downloads"
    mkdir -p "$HOME/Documents"
    mkdir -p "$HOME/Work"

    #Ger ägande över hemkatalogen till användaren
    chown -R "$USERNAME:$USERNAME" "$HOME"

    #Bara användaren kommer åt hemkatalogen
    chmod -R 700 "$HOME"

    #Skapar välkomstfilen, for-loopen lägger till en lista över övriga användare från inparametrarna "$@", exklusive den aktuella användaren
    echo "Välkommen $USERNAME" > "$WELCOME"
    echo "" >> "$WELCOME"
    echo "Övriga användare:" >> "$WELCOME"
    for user in "$@"
    do
        if [ "$user" != "$USERNAME" ]; then
        echo "$user" >> "$WELCOME"
        fi
    done

    #Ändrar rättigheter så alla kan läsa filen men bara ägaren kan ändra
    chmod 644 "$WELCOME"

done

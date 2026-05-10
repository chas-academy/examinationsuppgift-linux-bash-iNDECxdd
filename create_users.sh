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

    #Skapar mappar
    mkdir -p "$HOME/Downloads"
    mkdir -p "$HOME/Documents"
    mkdir -p "$HOME/Work"

    #Ger ägande över hemkatalogen till användaren
    chown -R "$USERNAME:$USERNAME" "$HOME"

    #Bara användaren kommer åt hemkatalogen
    chmod -R 700 "$HOME"

    #Skapar en användarlista med hjälp av en filtrering av /etc/passw där alla övriga användare med UID 1000 eller högre är med (vanliga användare)
    echo "Välkommen $USERNAME" > "$WELCOME"
    echo "Övriga användare:" >> "$WELCOME"
    awk -F: '$3 >= 1000 {print $1}' /etc/passwd | grep -v "$USERNAME" >> "$WELCOME"
    
    #Ändrar rättigheter så alla kan läsa filen men bara ägaren kan ändra den.
    chmod 644 "$WELCOME"
done

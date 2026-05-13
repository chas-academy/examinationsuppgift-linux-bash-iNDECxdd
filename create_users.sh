#!/bin/bash

echo $EUID

#if [ $EUID -ne 0 ]; then
#    echo "Måste köras som root"
#    exit 1
#fi

# Loopar genom alla parametrar och skapar användare samt hemkatalog med tillhörande mappar och välkomstfil
for USERNAME in $@; do
    echo "Skapar användare $USERNAME"
    #Skapar användare med hemkatalog (-m)
    useradd -m $USERNAME

    #HOMEDIRECTORY="/home/$USERNAME"
    #WELCOMETEXT="$HOMEDIRECTORY/welcome.txt"

    # Skapar mappar i hemkatalogen
    #mkdir -p "$HOMEDIRECTORY/Downloads" "$HOMEDIRECTORY/Documents" "$HOMEDIRECTORY/Work"

    #echo "Välkommen $USERNAME" >> "$WELCOMETEXT"

done

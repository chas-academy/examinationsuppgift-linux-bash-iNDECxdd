#!/bin/bash

#Kollar om användaren är root
if [ "$EUID" -ne 0 ]; then
    echo "måste köras som root"
    exit 1
fi

#Kollar så att parametrar skickas med till ./create_users.sh och visar felmeddelade om det inte finns några parametrar.
if [ "$#" -eq 0 ]; then
    echo "Du glömde ange användare"
    exit 1
fi

#Skapar användare, hemkatalog samt ändrar äganderätt och behörighet. Skapar även en välkomstfil som innehåller alla användare.
for USERNAME in "$@"; do
    echo "Lägger till användare: $USERNAME"
    useradd -m "$USERNAME"

    #Skapar en variabel för sökvägen till användarens hemkatalog samt skapar mappar i hemkatalogen.
    HOME_DIR="/home/$USERNAME"
    mkdir -p "$HOME_DIR/Documents" "$HOME_DIR/Downloads" "$HOME_DIR/Work"

    #Skapar välkomstfilen samt lägger till välkomstmeddelande i filen och lägger till text under det.
    echo "Välkommen $USERNAME" > "$HOME_DIR/welcome.txt"
    echo "" >> "$HOME_DIR/welcome.txt"
    echo "Övriga användare:" >> "$HOME_DIR/welcome.txt"

    #Lägger till de övriga användarna i välkomstfilen.
    for OTHERS in "$@"; do
        if [ "$OTHERS" != "$USERNAME" ]; then
            echo "$OTHERS" >> "$HOME_DIR/welcome.txt"
        fi
    done

    #Ändrar äganderätt och behörigheter så att användaren äger sin hemkatalog och endast kommer åt sina egna mappar.
    chown -R "$USERNAME:$USERNAME" "$HOME_DIR"
    chmod 700 "$HOME_DIR"
    chmod 700 "$HOME_DIR/Documents"
    chmod 700 "$HOME_DIR/Downloads"
    chmod 700 "$HOME_DIR/Work"
    chmod 644 "$HOME_DIR/welcome.txt"
done

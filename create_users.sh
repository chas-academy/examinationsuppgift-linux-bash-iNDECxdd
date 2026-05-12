#!/bin/bash 

# Skapar användare med hemkataloger och en välkomstfil

# Kollar om användaren är root eller inte
if [ "$EUID" -ne 0 ]; then 
    echo "Du har ej behörighet att köra detta script"
    exit 1 
fi 

# Skapar nya användare och mappar, for-loop används för att gå igenom alla parametrar i $@
for USERNAME in "$@"; do 
    # Skapar användare med en hemkatalog
    useradd -m "$USERNAME" 
    HOMEDIR="/home/$USERNAME" 
    WELCOMEFILE="$HOMEDIR/welcome.txt"

    # Skapar mappar i hemkatalogen 
    mkdir -p "$HOMEDIR/Documents" 
    mkdir -p "$HOMEDIR/Downloads" 
    mkdir -p "$HOMEDIR/Work"

    # Ger ägande över hemkatalogen till användaren
    chown -R "$USERNAME:$USERNAME" "$HOMEDIR"

    # Bara användaren kommer åt hemkatalogen 
    chmod -R 700 "$HOMEDIR" 

    # Skapar välkomstfilen, for-loopen lägger till en lista över övriga användare från inparametrarna "$@", exklusive den aktuella användaren
    echo "Välkommen $USERNAME" > "$WELCOMEFILE" 
    echo "" >> "$WELCOMEFILE" 
    echo "Andra användare:" >> "$WELCOMEFILE" 
    awk -F: '$3 >= 1000 {print $1}' /etc/passwd | grep -v "$USERNAME" >> "$WELCOMEFILE"

    # Ändrar rättigheter så alla kan läsa filen men bara ägaren kan ändra
    chmod 644 "$WELCOMEFILE" 
done 

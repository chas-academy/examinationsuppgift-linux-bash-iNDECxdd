#!/bin/bash

# Loopar genom alla parametrar och skapar användare samt hemkatalog med tillhörande mappar och välkomstfil
for USERNAME in $@; do
    echo "Skapar användare $USERNAME"
    #Skapar användare med hemkatalog (-m)
    useradd -m $USERNAME
done

#!/bin/bash

# Hämtar användarID
USER_ID=$(id -u) 

# echo $USER_ID

# Kollar om användarens ID är 0
if [[ $USER_ID -ne 0 ]]; then
    echo "Måste köras som root"
    exit 1
fi

# Loopar genom alla parametrar och skapar användare samt hemkatalog med tillhörande mappar och välkomstfil
for user in $@; do
    echo "Skapar användare $user"
    adduser $user 
    
    mkdir -p "/home/$user/Documents" "/home/$user/Downloads" "/home/$user/Work"
    
done

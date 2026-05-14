#!/bin/bash

#Kolla om scriptet körs som root eller inte
if [ "$EUID" -ne 0 ]; then
    echo "Måste köras som root"
    exit 1
fi

for USERNAME in "$@"; do
    useradd -m "$USERNAME"

    HOME_DIR="/home/$USERNAME"

    mkdir -p "$HOME_DIR/Documents" "$HOME_DIR/Downloads" "$HOME_DIR/Work"

    echo "Välkommen $USERNAME" > "$HOME_DIR/welcome.txt"
    echo "" >> "$HOME_DIR/welcome.txt"
    echo "Övriga användare:" >> "$HOME_DIR/welcome.txt"

    for OTHERS in "$@"; do
        if [ "$OTHERS" != "$USERNAME" ]; then
            echo "$OTHERS" >> "$HOME_DIR/welcome.txt"
        fi
    done

    chown -R "$USERNAME:$USERNAME" "$HOME_DIR"
    chmod 700 "$HOME_DIR"
    chmod 700 "$HOME_DIR/Documents"
    chmod 700 "$HOME_DIR/Downloads"
    chmod 700 "$HOME_DIR/Work"
    chmod 644 "$HOME_DIR/welcome.txt"
done

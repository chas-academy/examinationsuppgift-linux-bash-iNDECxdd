#!/bin/bash

#Lägger till mappar i skel som nya användare får automatiskt
sudo /etc/skel/Downloads
sudo /etc/skel/Documents
sudo /etc/skel/Work

#Skapar nya användare, $@ används för att ta emot flera parametrar utan att veta hur många vi får
sudo useradd "$@"

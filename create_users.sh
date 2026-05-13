for USERNAME in $@; do
    echo "Skapar användare $USERNAME"
    #Skapar användare med hemkatalog (-m)
    useradd -m $USERNAME
done

#!/bin/bash

echo $EUID

if [ $EUID -ne 0 ]; then
    echo "Måste köras som root"
    exit 1
fi

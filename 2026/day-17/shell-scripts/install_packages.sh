#!/bin/bash

read -p "Enter the PackageName You Want To Install: " package

if [ "$package" == "" ]; then
        echo "Please Enter The Package Name !!"
elif command -v "$package" > /dev/null 2>&1; then
        echo "$package is already installed!"
else
        echo "Installing $package ..."
        echo "Updating Package list..."
        sudo apt-get update > /dev/null 2>&1
        sudo apt-get install "$package" -y > /dev/null 2>&1
        
        echo "Checking if it's installed..."
        if command -v "$package" > /dev/null 2>&1; then
            echo "Success: $package is now installed!"
        else
            echo "Error: Failed to install $package."
        fi
fi


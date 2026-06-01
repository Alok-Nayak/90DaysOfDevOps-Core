#!/bin/bash

packages=('nginx' 'curl' 'wget')

for pkg in ${packages[@]}; do
	 echo "Checking status for: $pkg"

	 if  command -v $pkg  > /dev/null 2>&1; then
		 echo "Status: $pkg is ALREADY installed. Skipping..."
	else
		echo "Status: $pkg is MISSING. Attempting install..."
	fi

done


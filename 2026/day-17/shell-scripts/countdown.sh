#!/bin/bash

read -p "Enter a number to countdown: " number

while [ $number -gt 0 ]; do
	((number=$number -1))	

	echo $number

done

echo "Done!"

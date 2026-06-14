#!/bin/bash

name=$1
greet(){
	
	echo "Heloo, $name!"
}


add(){
	read -p "'(+)'Enter the first number:  " n1
	read -p "'(+)'Enter the second number: " n2

	sum=$(( $n1 + $n2 ))

	echo "The sum of $n1 + $n2 = $sum"
}



greet 
add

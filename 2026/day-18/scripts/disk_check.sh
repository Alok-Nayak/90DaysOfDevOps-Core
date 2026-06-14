#!/bin/bash

check_disk(){
	df -h / | awk 'NR==2 {print $3}'
}


check_memory(){
 free -h | awk 'NR==2 {print $3}'
}


main(){

	echo "Used disk: $(check_disk)"
	echo "Used RAM: $(check_memory)"
}

main

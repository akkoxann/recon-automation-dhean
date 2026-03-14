#!/bin/bash

set -x
: > ../logs/errors.log

read -p "1. Input new data
2. Use data since last used
Enter (1/2)" CEK

if [[ $CEK == 2 ]]; then
	echo "[SEPERATOR] ========== SEPERATING LOGS ==========" >> ../logs/progress.log
	
	echo "[Starting] Check using old data" >> ../logs/progress.log
	echo "[DATA] Using old data to check" >> ../logs/progress.log
	
	domain=($(cut ../input/domains.txt -d' ' -f1-5))
	
	echo "Which link you want to check again?"
	
	i=1
	for item in "${domain[@]}"; do
		echo "[INFO] Printing old data number $i" >> ../logs/progress.log
		echo "$i $item"
		((i++))
	done
	
	read -p "1 to 5?" FILE
	
	if (( $FILE <= 5 && $FILE >=1 )) ; then
		targetold=${domain[$((FILE-1))]}

	
		echo "[INFO] Adding new information from $targetold" >> ../logs/progress.log
	
		echo "$targetold was checked and we found this :" 
		subfinder -d $targetold -silent | httpx -status-code -mc 200 -silent -title | anew ../output/output.txt 2>> ../logs/error.log
	else
		echo "[ERROR] Input is either more than 5 or less than 1"
		echo "[ERROR] Input is either more than 5 or less than 1" >> ../logs/errors.log
	fi	

elif [[ $CEK == 1 ]] ; then
	echo "[Removing] Old data is being removed . . ." >> ../logs/progress.log
	
	: > ../output/output.txt
	: > ../logs/progress.log
	
	echo "[Starting] Adding new data" >> ../logs/progress.log
	
	read -p "Enter first link : " TARGET1
	read -p "Enter second link   : " TARGET2
	read -p "Enter third link  : " TARGET3
	read -p "Enter fourth link : " TARGET4
	read -p "Enter fifth link  : " TARGET5

	echo "$TARGET1 $TARGET2 $TARGET3 $TARGET4 $TARGET5" > ../input/domains.txt 2>> ../logs/error.log

	domain=($(cut ../input/domains.txt -d' ' -f1-5))

	for item in "${domain[@]}"; do
		echo "[INFO] Starting subfinder for $item" >> ../logs/progress.log
		echo "Showing data for $item" >> ../output/output.txt
		echo "Showing data for $item :"
		echo ""
		subfinder -d $item -silent | httpx -status-code -mc 200 -silent -title | sort -u |  tee -a ../output/output.txt 2>> ../logs/error.log
		echo " " >> ../output/output.txt
		echo ""
		echo "[INFO] Done for $item !" >> ../logs/progress.log
		echo "[INFO] Continuing . . ." >> ../logs/progress.log
	done

else
	echo "[ERROR] Input not valid"
	echo "[ERROR] Input not valid" >> ../logs/errors.log
fi



#!/bin/bash
OUTPUT_DIR=/root # set this to the root output directory you want to use
INPUT_FILE=/root/targetips.txt # set this to a txt file containing target IPs you want to scan
for ip in $(cat $INPUT_FILE);
do
	echo Starting $ip
	if [ ! -d "$OUTPUT_DIR/$ip" ]; then
		echo Creating Directory $OUTPUT_DIR/$ip
		mkdir -p $OUTPUT_DIR/$ip
	fi
	nmap -p- -sV $ip -oA $OUTPUT_DIR/$ip/nmap_-p-_-sV_$ip
	echo
	echo
	echo
done

#!/bin/bash
OUTPUT_DIR=/root # set this to the root output directory you want to use
INPUT_FILE=/root/targetips.txt # set this to a txt file containing target IPs you want to scan
for ip in $(cat $INPUT_FILE);
do
	echo Starting $ip
	echo ==============================
	if [ ! -d "$OUTPUT_DIR/$ip" ]; then
		echo ------------------------------
		echo Making Directory $OUTPUT_DIR/$ip
		echo ------------------------------
		mkdir -p $OUTPUT_DIR/$ip
	fi
	echo Starting NMAP http-enum script
	echo --------------------
	nmap -p80 --script http-enum $ip -oA $OUTPUT_DIR/$ip/nmap_-p80_--script_http-enum_$ip
	echo --------------------
	echo Starting Nikto
	echo
	nikto -h $ip -o $OUTPUT_DIR/$ip/nikto.txt
	echo --------------------
	echo Starting Gobuster common.txt
	echo
	gobuster -e -r -w /usr/share/seclists/Discovery/Web_Content/common.txt -u http://$ip > $OUTPUT_DIR/$ip/gobuster_common.txt
	cat $OUTPUT_DIR/$ip/gobuster_common.txt
	echo --------------------
done

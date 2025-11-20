#!/bin/bash

while read -p"> " STATE; do grep -i "$STATE" 1000cities.txt | awk -F"," -v state="$STATE" '{printf "%s, %s \n", $2, $4; sum += $4} END {print "\nTotal population of" state ": " sum}'; done

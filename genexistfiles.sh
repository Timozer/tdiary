#!/bin/bash

declare -a monthes=("Jar" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec")
for (( year = $1; year <= $2; year++ )); do
    if [ -d "./diary/$year" ]; then # if the foloder exist, then check if the file named .folderexist exist 
        if [ ! -f "./diary/$year/.folderexist" ]; then # if the .folderexist not exist, then touch it 
            echo "./diary/$year/.folderexist file doesn't exist, so I'll touch it"
            touch "./diary/$year/.folderexist"
        fi
        for month in "${monthes[@]}"; do
            if [ -d "./diary/$year/$month" ]; then
                if [ ! -f "./diary/$year/$month/.folderexist" ]; then
                    echo "./diary/$year/$month/.folderexist file doesn't exist, so I'll touch it"
                    touch "./diary/$year/$month/.folderexist"
                fi
            fi
        done
    fi
done

#!/bin/bash
#STEVEN PUTT - STPU6983

echo $# arguments
if [ -z "$1"]; then
	echo "Usage: grades.sh filename"
fi

fileName="$1"
while read line || [ -n "$line" ]; do
	read -a lineArray <<< $line
	g1=${lineArray[-1]//[$'\r']}
	g2=${lineArray[-2]}
	g3=${lineArray[-3]}
	gSum=$(($g1+$g2+$g3))
	aveGrade=$(($gSum/3))
	trimLine+=("$aveGrade [${lineArray[0]}] ${lineArray[2]}, ${lineArray[1]}")
	gradesArray+=( "${trimLine[@]}" )
	#//[$'\r']}" )
	#gradesArray+=(${trimLine[*]})
done < $fileName
#printf "%s\n" "${gradesArray[@]}"
IFS=$'\n' sorted=($(sort -u -k3,3d -k4,4d -k2,2n <<<"${gradesArray[*]}"))
printf "%s\n" "${sorted[@]}"

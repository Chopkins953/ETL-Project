#!/bin/bash
# This progarm accepts a file and returns the file with the header removed

usage="Usage: $0 file"

if [[ $# -ne 1 ]]
then
	echo "$usage"
	exit 1
fi
if [[ ! -f $1 ]]
then 
	echo "$usage"
	exit 1
fi

#makes a temp file
touch temp

#removes header
tail -n +2 $1 > temp

#replaces originial file
mv temp "$1"



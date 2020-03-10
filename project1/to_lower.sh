#!/bin/bash

#
# this script accepts a file and converts all letters from upper case
# to lowercase. the script then sends the output to a file and replaces
# the given file with the temporary file
#

usage="Usage: $0 file"

if [[ $# -ne 1 || ! -f $1 ]]
then 
	echo "$usage"
	exit 1
fi

touch temp

tr '[A-Z]' '[a-z]' < $1 > temp

mv temp $1





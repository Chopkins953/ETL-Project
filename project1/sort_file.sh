#!/bin/bash

#
# this program accepts a file and sorts the file based on the first column
# it then places the output into a file named tempsort
#

usage="Usage: $0 [file]"
if [[ $# != 1 ]]
then 
	echo $usage
	exit 1
fi

sort -k 1,1 $1 > tempsort








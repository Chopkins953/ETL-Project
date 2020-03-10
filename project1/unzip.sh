#!/bin/bash
#
# this program accepts a compressed file and 
# unzips the file that  
#
usage="Usage: $0 compressed file"

#test if it has arguments passed
if [[ $# -lt  1 ]]
then
	echo $usage
	exit 1
fi
#echo "passed first check"
file=$1
#test if the first argument is a file with a .gz extension or a bz extension
if [[ $1 != *.gz && $1 != *.bz2 ]]
then
	echo $usage
	exit 1
fi
#echo "passed extension check"
#newFile=${1%%*.}
#path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/DEV/NULL 2>&1 && pwd )"

#echo "path = $path"
if [[ $1 == *.gz ]]
then
	tar xzf $1 
fi

if [[ $1 == *.bz2 ]]
then 
	bunzip2 $1
fi

file=${1%.*}

mv $file transaction.csv



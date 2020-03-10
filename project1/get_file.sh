#!/bin/bash

#
# this script accepts three parameters and utilizes them in an scp command to 
# take a file from a remote server and put it into the current directory
#


usage="Usage: $0 [servername/ip address] [userid] [full path to file]"
if [[ $# != 3 ]]
then 
	echo $usage
	exit 1
fi

scp $2@$1:$3 .


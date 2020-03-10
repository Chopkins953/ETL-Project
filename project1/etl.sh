#!/bin/bash
usage="Usage: $0 [servername/ip] [userid] [full file path]"

if [[ $# != 3 ]]
then
	echo $usage
	exit 1
fi

echo "getting file..."
./get_file.sh $1 $2 $3

if [[ $? != 0 ]]
then
       	echo "error could not scp the file exiting"
        exit 1
fi

zFile=${3##*/}
file=${zFile%.*}
name=transaction.csv


#echo $zFile
if [[ -f $file ]]
then
        echo "error could not get file exiting"
        exit 1
fi
echo "unzipping and renaming file..."
./unzip.sh $zFile

if [[ ! -f "transaction.csv" ]]
then
        echo "error could not generate transaction-rpt exiting"
        exit 1
fi

echo "removing header..."
./rm_header.sh $name
echo "cleaning data..."
./to_lower.sh $name
#echo "past to_lower"
./clean_genders $name

if [[ ! -f "gender_temp" ]]
then
	echo "error could not remove genders exiting"
	exit 1
fi
cp gender_temp $name

#echo "past clean genders"
./find_exceptions gender_temp

if [[ ! -f "temptransaction" ]]
then
        echo "error could not extract exceptions exiting"
        exit 1
fi

cp temptransaction $name


#echo "Past find exceptions"
./cut_dollars temptransaction

if [[ ! -f "cutfile" ]]
then
	echo "error could not remove $ exiting"
	exit 1
fi

cp cutfile $name

#echo "past cut dollars"

echo "sorting data..."

./sort_file.sh cutfile

if [[ ! -f "tempsort" ]]
then
	echo "error could not sort file exiting"
	exit 1
fi

cp tempsort $name

echo "generating summary.csv.."
./accumulate tempsort

if [[ ! -f "tempsum" ]]
then
        echo "error could not generate summary exiting"
	exit 1
fi

sort -k2,2 -k3,3 -k4,4 -k5,5 tempsum > summary.csv

echo "generating transaction-rpt..."
./make_report $name

#if [[ ! -f "newfile" ]]
#then
#       echo "error could not generate transaction-rpt exiting"
#       exit 1
#fi

(head -n 3 transaction-rpt && tail -n +5 transaction-rpt | sort -k 2,2nr -k 1,1) > newfile

if [[ ! -f "newfile" ]]
then
        echo "error could not generate transaction-rpt exiting"
        exit 1
fi

cp newfile transaction-rpt

./make_report2 $name

#if [[ ! -f "newfile2" ]]
#then
#        echo "error could not generate purchase-rpt exiting"
#        exit 1
#fi

(head -n 3 purchase-rpt && tail -n +5 purchase-rpt | sort -k 3,3nr -k 1,1 -k 2,2) > newfile2

if [[ ! -f "newfile2" ]]
then
        echo "error could not generate transaction-rpt exiting"
        exit 1
fi

cp newfile2 purchase-rpt

echo "removing temporary files..."
rm gender_temp cutfile newfile newfile2 tempsort tempsum temptransaction


echo "Complete"
#cat transaction-rpt | awk 'NR<3{print;next}{print| "sort -k2,2nr -k1,1"  > temp

#sort -k 2,2nr -k1,1 transaction-rpt > temp-rpt

#mv temp-rpt transaction-rpt


#!/bin/bash
dir=$1
if [ ! -d $dir ] ; 
then
    mkdir $dir
    pwd

else
    rm -r $dir/*
fi

cd $dir
for ((i=1; i<=10; i++)) 
do
    touch file_$`uuidgen -r`.txt
done
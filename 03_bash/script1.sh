#!/bin/bash
x="this is x variable of string"
echo "x test is: $x"
y=10
z=15
echo -e "$x\n$y\n$z"
sum=$((y + z))
echo "Sum: $sum"

echo -n "Enter Number: "
read num
if [ $num -gt 10 ]; then
    echo "Number is greater than 10"
else
    echo "Number is NOT greater than 10"
fi

read -p "Enter color: " color
echo "Your favorite color is: $color"
 
dir=Dir_$(whoami)
mkdir $dir

 filepath=""
counter=0
while [ $counter -le 5 ]; 
do
    echo "Counter: $counter"
    ((counter++))
    filepath=${dir}/file_${counter}.txt
    touch $filepath
    echo $counter >> $filepath
    cat $filepath
    # ls -l $dir
done


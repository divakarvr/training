#! /bin/bash 

for i in 1 2 3 4
do
    echo $(($i * 10)) 
done

for i in "1 2 3 4"
do
    echo $i
done

for i in '1 2 3 4' '56'
do
    echo $i
done


for  i in `pwd` $(ls) "hi" "hello" 
do
    echo $i 
done 

########################
# for i in <space separated values>
# do 
#       <operational code>
# done 
#########################
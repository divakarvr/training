#! /bin/bash 

i="hi"

while [ $i == "hi" ]
do
    echo 1
    i="dude"
done 


while read i
do 
    echo ${i} 
done < /Users/praveenvaranasi/Professional/freelance/repos/diwakar-training/shell/demo-scripts/file.txt



############################################
#  while [condition] 
#  do
#       <operational code>
#   done
#
#  while read <var>
#  do
#       <ops code>
#  done < [file-path]
############################################
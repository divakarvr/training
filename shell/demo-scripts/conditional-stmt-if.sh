#! /bin/bash

name='divaa'

if [ ${name} != "divaa" ]; then
        echo "Its true dude"
    elif [ ${name} == "diva" ]; then
        echo "diva dude"
    else
        echo "no match yar"
fi


age=29
if [ ${age} -eq 30 ]; then 
        echo "Its 30 dude"
    elif [ ${age} -ge 30 ]; then 
        echo "its more than 30"
    elif [ ${age} -le 30 ]; then
        echo "its less than 30"
    else
        echo "no valid match"      
fi

if [ ${age} -ne 30 ]; then 
    echo "Its okay"
fi


if [ -f $(pwd)/file.txt ]; then 
    echo "its a file"
fi

if [ -d `pwd`/../demo-scripts ]; then 
        echo "is a directory"
    else
        echo 'not a directory dude'
fi

if [ -x /opt/homebrew/opt/coreutils/libexec/gnubin/pwd ]; then 
        echo "is an executable"
    else
        echo "not an executable"
fi

if [ -e `pwd`/../demo-scripts ]; then 
        echo 'file/dir exists'
    else 
        echo 'file/dir not exists'
fi

################################################################
#if [ ]
#    then 
#        < code to execute if the condition is true > 
#    else
#        < code to execute if the condition is false > 
#fi
################################################################
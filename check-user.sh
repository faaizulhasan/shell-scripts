#!/bin/bash
#check username is root or not

echo $USER
if [ $USER == root ] ; then
        printf "Would you like to continue with root user? (Y/N)\n"
        read answer
        if [ $answer == "N" ] || [ $answer == "n" ]; then
        echo "Try login in with other user"
        exit 1
        fi
fi
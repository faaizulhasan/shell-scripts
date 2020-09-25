#!/bin/bash

PROJECT_NAME=$1
PROJECT_TYPE=$2
DOMAIN=$3
PORT=$4
DATABASE_NAME=$5


#VALIDATION
if ![ $PROJECT_NAME ]
then echo "[1]Project Name is required"; exit 0
else if ![ $PROJECT_TYPE ]
then echo "[2]Project type (node or php) is required"; exit 0
else if ![ $DOMAIN ]
then echo "[3]Domain Name is required"; exit 0
else if ![ $PORT ]
then echo "[3]Port is required"; exit 0
fi


sh ./git.sh $PROJECT_NAME
if [ $PROJECT_TYPE == 'php' ]
then sh ./nginx-php-conf.sh $PROJECT_NAME $DOMAIN 
else sh ./nginx-node-conf.sh $PROJECT_NAME $DOMAIN $PORT
fi

sudo nginx -t

printf "Do you like to reload nginx (Y/N)"
read res

if [ $res == 'Y' ] | [ $res == 'y' ]
then sudo systemctl reload nginx
fi


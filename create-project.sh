#!/bin/bash

PROJECT_NAME=$1
PROJECT_TYPE=$2
DOMAIN=$3
PORT=$4
DATABASE_NAME=$5
MYSQL_ROOT_USER=root
MYSQL_ROOT_PASS="23123_+_+WaM"

function showHelp(){
	echo "Arguments: [1]Project name [2]Project Type [3]Domain [4]Port(O) [5]DatabaseName(O)"
}

random-string()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

#VALIDATION
if ! [ $PROJECT_NAME ]
then echo "[1]Project Name is required"; showHelp; exit 0
elif ! [ $PROJECT_TYPE ]
then echo "[2]Project type (node or php) is required"; showHelp; exit 0
elif ! [ $DOMAIN ]
then echo "[3]Domain Name is required"; showHelp; exit 0
elif ! [ $PORT ]
then echo "[3]Port is required"; showHelp; exit 0
fi


sh ./git.sh $PROJECT_NAME
if [ $PROJECT_TYPE == 'php' ]
then sh ./nginx-php-conf.sh $PROJECT_NAME $DOMAIN 
else sh ./nginx-node-conf.sh $PROJECT_NAME $DOMAIN $PORT
fi

#CREATING MYSQL USER FOR THIS PROJECT
RANDOM_PASSWORD=$(random-string)
DB_USERNAME=$PROJECT_NAME-user

mysql -u $MYSQL_ROOT_USER -p$MYSQL_ROOT_PASS -e  "CREATE DATABASE "$PROJECT_NAME"; CREATE USER '"$DB_USERNAME"'@'%' IDENTIFIED BY '"$RANDOM_PASSWORD"'; GRANT ALL PRIVILEGES ON "$PROJECT_NAME".* TO '"$DB_USERNAME"'@'%'; FLUSH PRIVILEGES;"

echo "================================="
echo "Mysql User: $DB_USERNAME"
echo "Mysql PasswordL: $RANDOM_PASSWORD"
echo "================================="

#checking nginx status
sudo nginx -t

printf "Do you like to reload nginx (Y/N)"
read res

if [ $res == 'Y' ] | [ $res == 'y' ]
then sudo systemctl reload nginx
fi


#!/bin/bash

userid=$(id -u)
R="\e[31m"
N="\e[0m"
echo "plz enter your mysql password"
read "password"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
    echo "$2 IS ....FAILURE"
    exit 1
    else
    echo "$2 is .....success"
    fi
}

if [ $userid -ne 0 ]
then
    echo "you are not in super user:"
    exit 1
else
    echo "you are at super user"
fi


dnf install mysql-server -y

VALIDATE $?  "INSTALLING MYSQL"

systemctl enable mysqld

VALIDATE $?  "ENABLE MYSQL"


systemctl start mysqld

VALIDATE $?  "START MYSQL"

#mysql_secure_installation --set-root-pass ExpenseApp@1

#VALIDATE $?  "SETTING USER AND PASSWORD"

#Below code will be useful for idempotent nature
mysql -h 172.31.19.151 -uroot -p${password} -e 'show databases;'
if [ $? -ne 0 ]
then
     mysql_secure_installation --set-root-pass ${password}
else
    echo  -e "already username and password is set ..$R..SKIPPING $N"
fi

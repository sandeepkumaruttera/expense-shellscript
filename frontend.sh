#!/bin/bash

userid=$(id -u)

VALIDATE(){
    if [ $1 -ne 0]
    exit 1
    echo "$2 IS ....FAILURE"
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

mysql_secure_installation --set-root-pass ExpenseApp@1

VALIDATE $?  "SETTING USER AND PASSWORD"
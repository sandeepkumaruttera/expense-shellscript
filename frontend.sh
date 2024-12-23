#!/bin/bash

userid=$(id -u)
R="\e[31m"
N="\e[0m"


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

dnf install nginx -y 
VALIDATE $?  "install nginx"

systemctl enable nginx
VALIDATE $? "enable nginx"

systemctl start nginx
VALIDATE $? "start nginx"

rm -rf /usr/share/nginx/html/*


curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip

VALIDATE $? "frontend dowloading"


cd /usr/share/nginx/html


unzip /tmp/frontend.zip

VALIDATE $? "unzip frontend"

cp /home/ec2-user/expense-document/expense.conf  /etc/nginx/default.d/expense.conf


systemctl restart nginx

VALIDATE $? "restart nginx"
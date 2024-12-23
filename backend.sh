#!/bin/bash


userid=(id -u)



VALIDATE(){
    if [ $1 -ne 0 ]
    then
    echo "$2 is .....failure"
    exit 1
    echo "$2 is ....success"
    fi
}

if [ $userid -ne 0 ]
then 
    echo "you are not in super user"
    exit 1
    else 
    echo "you are in super user"
fi


dnf module disable nodejs -y
VALIDATE $? "disable nodejs"

dnf module enable nodejs:20 -y
VALIDATE $? "enable nodejs"


dnf install nodejs -y
VALIDATE $? "install nodejs"

id expense
if [ $? -ne 0 ]
then
    useradd expense
    VALIDATE $? "CREATING useradd"
    exit 1 
else 
    echo "already expense username is created"
fi

mkdir -p /app

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip


cd /app

rm -rf /app/*
unzip /tmp/backend.zip

cd /app
npm install

cp /home/ec2-user/expense-document/backend.service     /etc/systemd/system/backend.service                                                   


systemctl daemon-reload


systemctl start backend


systemctl enable backend


dnf install mysql -y


mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pExpenseApp@1 < /app/schema/backend.sql


systemctl restart backend

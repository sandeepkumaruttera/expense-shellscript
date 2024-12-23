#!/bin/bash


userid=(id -u)

if [ userid -ne 0 ]
then 
    echo "you are not in super user"
    exit 1
    else 
    echo "you are in super user"
fi
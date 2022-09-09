#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR

cd ../key/smtp
host=user.tax
openssl genrsa -out $host.pem 2048

txt=$(openssl rsa -in $host.pem -pubout -outform der 2>/dev/null | openssl base64 -A)

year=$(date "+%Y")

echo -e "\nset txt\n$year._domainkey.$host"
echo -e "v=DKIM1; k=rsa; p=$txt"



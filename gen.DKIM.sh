#!/usr/bin/env bash

DIR=$(dirname $(dirname $(realpath "$0")))
host=$1
SMTP=$DIR/key/smtp/$host

mkdir -p $SMTP
cd $SMTP
day=$(node -e "console.log(parseInt(new Date()/1e6/864).toString(36))")

if [ -f "$day.pem" ]; then
echo "exist $SMTP/$day.pem"
else
openssl genrsa -out $day.pem 2048
git add .
git commit -m "."
git push
fi


txt=$(openssl rsa -in $day.pem -pubout -outform der 2>/dev/null | openssl base64 -A)

echo -e "\nset txt\n$day._domainkey.$host"
echo -e "v=DKIM1; k=rsa; p=$txt"

#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR

cd ../key/smtp
host=user.tax
day=$(node -e "console.log(parseInt(new Date()/1e6/864).toString(36))")

mkdir -p $host
cd $host

openssl genrsa -out $day.pem 2048

git add .
git commit -m "."
git push

txt=$(openssl rsa -in $day.pem -pubout -outform der 2>/dev/null | openssl base64 -A)

echo -e "\nset txt\n$day._domainkey.$host"
echo -e "v=DKIM1; k=rsa; p=$txt"

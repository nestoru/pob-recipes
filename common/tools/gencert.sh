#!/bin/bash -e
# gencert.sh
# @author: Nestor Urquiza
# @date: 20170109
# description: generates a private key (.key), a certificate request (.csr) and a temporary (365 days) self signed certificate request (.crt) 

USAGE="Usage: `basename $0` <countryCode> <state> <city> <company> <organizationalUnitName> <domain> <email>"

if [ $# -ne "7" ] 
then
  echo $USAGE
  exit 1 
fi

countryCode=$1
state=$2
city=$3
company=$4
organizationalUnitName=$5
domain=$6
email=$7

openssl req -nodes -sha256 -newkey rsa:2048 -keyout ${domain}.key -out  ${domain}.csr -batch -subj "/C=$countryCode/ST=$state/L=$city/O=$company/OU=$organizationalUnitName/CN=$domain/emailAddress=$email"
openssl x509 -req -days 365 -sha256 -in ${domain}.csr -signkey ${domain}.key -out ${domain}.crt

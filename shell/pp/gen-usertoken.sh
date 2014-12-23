#!/bin/sh

year_month=$1
user_pwd_file=$2

while read LINE;
do
    user_pwd=($LINE)
    user_token=`md5 -q -s ${user_pwd[1]}${year_month}`
    user_token=`echo "${user_pwd[0]}&${user_token}" | base64`
    echo ${user_pwd[0]},${user_token/Cg==/}
done < ${user_pwd_file}


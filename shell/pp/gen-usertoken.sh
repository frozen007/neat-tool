#!/bin/sh

year_month=$1
user_pwd_file=$2

#year_month:20152 201510 
#mysqluser -e "select uid,password from user_detail_info_1 where password <> '' and avatar like '%.jpg' limit 300" > user.txt
#

while read LINE;
do
    user_pwd=($LINE)
    user_token=`md5 -q -s ${user_pwd[1]}${year_month}`
    user_token=`echo "${user_pwd[0]}&${user_token}" | base64`
    echo ${user_pwd[0]},${user_token/Cg==/}
    #echo ${user_pwd[0]},${user_token}
done < ${user_pwd_file}


#!/bin/sh

keys_prefix=$1
redis_host=$2
redis_port=$3
list_only=$4

#redis_pass=uhHK2tCRSaL7uzv6iuu5dsVvQfXhtPxfsOjWCRwNZUnDyy3GcIoPgAt1T3FQtUKW
redis_pass=yzl
redis_cli_cmd=redis-cli

scan_cursor=0

while [ 1 ]; do
    scan_res=(`${redis_cli_cmd} -h ${redis_host} -p ${redis_port} -a ${redis_pass} scan $scan_cursor match ${keys_prefix}* count 10000`)
    scan_cursor=${scan_res[0]}
    scan_len=${#scan_res[@]}
    echo cursor:$scan_cursor,len:$scan_len

    if [ "$scan_len" -gt 1 ]; then
        del_keys=""
        for (( i = 1; i < $scan_len; i++ )); do
            del_keys="${del_keys} ${scan_res[$i]}"
        done
        if [ "$list_only" = "list" ]; then
            echo "deleted keys="$del_keys
        else
            ${redis_cli_cmd} -h ${redis_host} -p ${redis_port} -a ${redis_pass} del $del_keys
        fi
    fi
    if [ "$scan_cursor" -eq 0 ]; then
        break
    fi
done

echo "end"


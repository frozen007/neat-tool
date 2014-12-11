#!/bin/sh
redis_list_file=$1
shift
redis_cmd=$*

while read LINE;
do
    redis_info=($LINE)
    echo ${redis_info[0]}:${redis_info[1]}
    redis-cli -h ${redis_info[0]} -p ${redis_info[1]} -a ${redis_info[2]} ${redis_cmd}
done < ${redis_list_file}

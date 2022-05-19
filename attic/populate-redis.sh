#!/bin/bash
#
# Populates matched identifiers and associated content ids  
# into a redis sets 
#
# Usage: 
#   ./populate-redis.sh [pattern name]
#
# Prerequisites: a running kafka broker and a kafka topic (see https://github.com/bio-guoda/preston-scripts/tree/main/server) and redis server (see https://redis.io) .
#



PATTERN_NAME=${1:-email}
./consume-link-registry.sh ${PATTERN_NAME}\
 | pv -l\
 | sed 's+^+sadd\t+g'\
 | awk -F '\t' 'BEGIN { ORS="" } { print "*3\r\n$" length($1) "\r\n" $1 "\r\n$" length($2) "\r\n" $2 "\r\n$" length($3) "\r\n" $3 "\r\n" }'\
 | redis-cli --pipe 

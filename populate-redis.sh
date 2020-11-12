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
date
time ./consume-link-registry.sh ${PATTERN_NAME} | pv -l | sed 's+^+sadd "+g' | sed 's+$+"\r+g' | sed 's+\t+" "+g' | redis-cli --pipe 
date

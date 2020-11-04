#!/bin/bash
#
# Reads an HTTP request from stdin, runs the preston command indicated in the request URI, and returns the output of that command.
#
# Designed for use with socat,
#
#   socat TCP4-LISTEN:8080,reuseaddr,fork SYSTEM:"./preston-web-service.sh" 
#
# then e.g.
#
#   curl 'localhost:8080/version'
#
#   curl 'localhost:8080/cat/hash://sha256/abc...'
# 

REMOTES=${1:-file://$(pwd)/data}

read -r REQUEST_METHOD REQUEST_URI REQUEST_HTTP_VERSION

# Remove leading and trailing / characters from REQUEST_URI, split the result into CMD and ARGS
IFS=/ read -r CMD ARGS <<<"$(echo $REQUEST_URI | sed -e 's:^/*::' -e 's:/*$::')"

# Decide how to handle the request
STATUS="200 OK"
case "$CMD$ARGS" in
    version)
        HEADER="Content-type: text/plain;charset=UTF-8"
        ;;
    "get$ARGS"|"cat$ARGS"|ls|history)
        HEADER="Content-type: text/plain"
        OPTIONS="--no-cache --remote $REMOTES"
        ;;
    *)
        STATUS="400 Bad Request"
        FAIL=true
        ;;
esac

# Send a response
echo "HTTP/1.1 $STATUS"
[ -n "$HEADER" ] && echo "$HEADER"
echo
[ -z "$FAIL" ] && preston $CMD $OPTIONS $ARGS


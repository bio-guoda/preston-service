#!/bin/bash
#
# Reads an HTTP request from stdin, runs the preston command indicated in the request URI, and returns the output of that command.
#
# Designed for use with socat,
#
#   socat TCP4-LISTEN:8081,reuseaddr,fork SYSTEM:"./preston-registry-service.sh" 
#
# then e.g.
#
#   curl 'localhost:8081/find/arctos/http://arctos.database.museum/guid/UAM:Herb:74954'
# 

set -xe

read -r REQUEST_METHOD REQUEST_URI REQUEST_HTTP_VERSION

# Remove leading and trailing / characters from REQUEST_URI, split the result into CMD and ARGS
IFS=/ read -r METHOD PATTERN_NAME IDENTIFIER_PATTERN <<<"$(echo $REQUEST_URI | sed -e 's:^/*::' -e 's:/*$::')"

# Decide how to handle the request
STATUS="200 OK"
HEADER="Content-type: text/plain"

case "$METHOD" in
    find)
        HEADER="Content-type: text/plain"
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
[ -z "$FAIL" ] && /bin/sh -c "./find-datasets-with-link-pattern.sh '$PATTERN_NAME' '$IDENTIFIER_PATTERN'"



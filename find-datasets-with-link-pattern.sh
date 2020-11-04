#!/bin/bash
#
# print all titles of dataset containing
# arctos specimen ids
#
# Prerequisites: kafkacat, xmllint, socat, preston etc.
#
#

PATTERN_NAME=${1:-arctos}
IDENTIFIER_PATTERN=${2:-"http://arctos.database.museum/guid/UAM:Herb:74954"}

set -xe

kafkacat -C -e -b localhost:9092 -t ${PATTERN_NAME}\
 | grep "$IDENTIFIER_PATTERN"\
 | cut -f2\
 | uniq\
 | awk '{ print "https://preston.guoda.bio/cat/zip:" $1 "!/eml.xml" }'

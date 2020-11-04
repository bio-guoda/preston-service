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

kafkacat -e -b localhost:9092 -t ${PATTERN_NAME}\
 | grep "$IDENTIFIER_PATTERN"\
 | cut -f2\
 | uniq\
 | awk -v quote="'" '{ print quote "https://preston.guoda.bio/cat/zip:" $1 "!/eml.xml" quote }'

#/bin/bash
#

set -x

cat index.md\
 | pandoc -s -t html5\
 > index.html

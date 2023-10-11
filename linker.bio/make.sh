#/bin/bash
#

set -x

cat index.md\
 | pandoc -s -t html5\
 > index.html

cat index.md\
 | pandoc -s -t docx\
 > linker.bio.docx

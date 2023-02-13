#!/bin/bash
#
# see https://github.com/bio-guoda/preston-brit-2022/blob/main/sample-1000-image-urls.sh
#

#!/bin/bash
#
# see https://github.com/bio-guoda/preston-brit-2022/blob/main/sample-1000-image-urls.sh
#

preston track https://sernecportal.org/portal/content/dwca/VDB_DwC-A.zip\
 https://sernecportal.org/portal/content/dwca/NLU_DwC-A.zip\
 https://portal.torcherbaria.org/portal/content/dwca/BRIT_DwC-A.zip\
 | preston dwc-stream\
 | grep URI\
 | jq --raw-output '.["http://rs.tdwg.org/ac/terms/accessURI"], .["http://rs.tdwg.org/ac/terms/thumbnailAccessURI"], .["http://rs.tdwg.org/ac/terms/goodQualityAccessURI"]'\
 | grep -v null\
 | grep bisque\
 | grep cyverse\
 | grep -oP "00-[a-zA-Z0-9]+"\
 | uniq\
 | sed 's+^+https://bisque.cyverse.org/blob_service/+g'\
 > blob-urls.tsv

# tracks blob urls

cat blob-urls.tsv | xargs -L128 preston track 


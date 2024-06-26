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
  > image-urls.tsv

# tracks image urls

cat image-urls.tsv | xargs -L25 preston track 
 # randomly sample 1000 expected image urls
 #shuf -n 1000 image-urls.tsv | xargs -L25 preston track 

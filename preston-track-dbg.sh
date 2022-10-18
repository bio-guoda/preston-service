#!/bin/bash
#
# see 
# https://github.com/bio-guoda/preston-dbg-2022
# https://github.com/bio-guoda/preston/issues/193

# track some Denver Botanical Garden related DwC-A
#
preston track https://intermountainbiota.org/portal/content/dwca/DBG-KHD_DwC-A.zip\
 http://ipt.vertnet.org:8080/ipt/archive.do?r=dbg_chatfieldfarms_riparianrestoration\
 http://scan-bugs.org/portal/content/dwca/DBG-DBGA_DwC-A.zip\
 http://ipt.vertnet.org:8080/ipt/archive.do?r=dbg_mirabilis-rotundifolia_demogarphicmonitoring\
 http://ipt.vertnet.org:8080/ipt/archive.do?r=dbg_physaria-bellii_demographicmonitoring\
 | preston dwc-stream\
 | grep URI\
 | jq --raw-output '.["http://rs.tdwg.org/ac/terms/accessURI"], .["http://rs.tdwg.org/ac/terms/thumbnailAccessURI"], .["http://rs.tdwg.org/ac/terms/goodQualityAccessURI"]'\
 | grep -v null\ 
  > image-urls.tsv

# tracks related image urls
cat image-urls.tsv | xargs -L25 preston track 
 # randomly sample 1000 expected image urls
 #shuf -n 1000 image-urls.tsv | xargs -L25 preston track 

#!/bin/bash
#
#

set -x

download_links_for() {
  local prefix="$1"
  curl "$prefix"\
   | grep -oE 'href="[^/][^"]+[.][^"]+'\
   | sed "s+href=\"+${prefix}+g"
}

preston track\
 --tmp-dir /tmp\
 -f <(echo\
  $(download_links_for "https://download.checklistbank.org/col/")\
  $(download_links_for "https://download.checklistbank.org/col/annual/")\
  $(download_links_for "https://download.checklistbank.org/col/monthly/")\
  | tr ' ' '\n'\ 
  )

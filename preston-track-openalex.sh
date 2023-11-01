#!/bin/bash
#
# Tracks https://openalex.org snapshots 
# https://docs.openalex.org/download-all-data/openalex-snapshot
#
# Priem, J., Piwowar, H., & Orr, R. (2022). OpenAlex: A fully-open index of scholarly works, authors, venues, institutions, and concepts. ArXiv. https://arxiv.org/abs/2205.01833
# 

set -xe
 
# first self-archive this script
cat $0\
 | preston track 

# assign alias for readability
preston head\
 | preston cat\
 | grep "hasVersion"\
 | grep -oE "hash://sha256/[a-f0-9]{64}"\
 | tail -n1\
 | sed 's/^/alias urn:example:track-openalex.sh /g'\
 | xargs preston 

# track the s3 bucket listing
preston track "https://openalex.s3.amazonaws.com/"

# extract and track openalex snapshot resources
preston head\
 | preston cat\
 | grep hasVersion\
 | preston cat\
 | grep -oE "<Key>[^<]+"\
 | sed -E 's+<Key>++g'\
 | sed 's+^+https://openalex.s3.amazonaws.com/+g'\
 | xargs -L50 preston track

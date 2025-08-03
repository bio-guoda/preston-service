#!/bin/bash
#
# index provenance graph associated with an anchor
# into oxigraph  
#

# 2025-07-01 version
GIB_VERSION=hash://sha256/9dcf2e5497722e4f8184dffbf1e39daabb72a47ccbefb9c1177b17261ac337a5

preston ls\
 --anchor ${GIB_VERSION}\
 --remote https://linker.bio\
 | sed -E 's/(<)([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})([^ ]*)(>)/<urn:uuid:\2>/g'\
 | pv -l\
 | ../bin/oxigraph load --lenient --format nq --location preston-gib
 


#!/bin/bash
#
# index provenance graph associated with an anchor
# into oxigraph  
#


preston ls\
 --anchor hash://sha256/a0d1df102236a0959daf70cd3cf5dd16ffdca043b53f4df08899adf883d85812\
 --remote https://linker.bio\
 | sed -E 's/(<)([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})([^ ]*)(>)/<urn:uuid:\2>/g'\
 | pv -l\
 | ../bin/oxigraph load --lenient --format nq --location preston-gib
 


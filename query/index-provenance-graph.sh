#!/bin/bash
#
# index provenance graph associated with an anchor
# into oxigraph  
#


preston ls\
 --anchor hash://sha256/5b7fa37bf8b64e7c935c4ff3389e36f8dd162f0705410dd719fd089e1ea253cd\
 --remote https://linker.bio\
 | sed -E 's/(<)([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})([^ ]*)(>)/<urn:uuid:\2>/g'\
 | pv -l\
 | ./oxigraph_server_v0.3.22_x86_64_linux_gnu load --lenient --format nq --location preston-gib
 


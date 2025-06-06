#!/bin/bash
#
#  Load version preston provenance graph into oxigraph store.
# 
# see https://github.com/bio-guoda/preston/issues/199#issuecomment-1858618208
#

preston ls\
 --anchor hash://sha256/60e8810194e23f374b7c18947f5c37c56fe73b074f6617d3bdae845eab925fc1\                    
 --remote https://linker.bio\
 | sed -E 's/(<)([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})([^ ]*)(>)/<urn:uuid:\2>/g'\
 | pv -l\
 | ../bin/oxigraph load --lenient --format nq --location preston-gib

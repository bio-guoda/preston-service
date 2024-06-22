#!/bin/bash
#
# Tracks Wikidata taxon items (or items containing https://www.wikidata.org/wiki/Q16521)
# from latest data dump in line json (one json object per line)
#
# see https://linker.bio/hash://sha256/6f4fac44054d54ec3006d091ba702f872b3f4d013628add98fcca08a3b768962
# or
# https://gist.github.com/jhpoelen/f4a2a98ebbf13c6675f0e5e196f64a25/b7fdc05aeb5cff3727f3109dec18a60abe7fdc1e
# for bash script used to track the wikidata taxa
#

preston bash\
 --remote https://softwareheritage.org\
 -c hash://sha256/6f4fac44054d54ec3006d091ba702f872b3f4d013628add98fcca08a3b768962

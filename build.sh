#! /bin/sh

# Run this script from its current directory,
# with the directory of the SeBa source code as its argument
# For example,
#   sh build.sh $OHME/codes/SeBa
#
# The script will clean and build SeBa using Emscripten,
# then copy the necessary files (seba.js and seba.wasm)
# to the current directory, so it can be found by the
# webserver

script=$(readlink -f "$0")
scriptdir=$(dirname "$script")


sebadir="$1"
echo "Building SeBa in $sebadir"

cd $sebadir

make clean

# Note: this builds an ES6 (EcmaScript 6) *module*, not a plain JavaScript file. Import accordingly:
# import createMyProg from './myprog.js';
LDFLAGS="-s MODULARIZE -s -s EXPORT_ES6 -s EXPORTED_FUNCTIONS=\"['_main']\" -s ENVIRONMENT='web' -s EXPORTED_RUNTIME_METHODS='[\"FS\",\"callMain\"]' -s INVOKE_RUN=0" CC=emcc CXX=em++ AR=emar RANLIB=emranlib make
cd dstar
LDFLAGS="-s MODULARIZE -s -s EXPORT_ES6 -s EXPORTED_FUNCTIONS=\"['_main']\" -s ENVIRONMENT='web' -s EXPORTED_RUNTIME_METHODS='[\"FS\",\"callMain\"]' -s INVOKE_RUN=0" CC=emcc CXX=em++ AR=emar RANLIB=emranlib make
# Run the last compilation command again, with a different output file, seba.js
em++ -I../include -I../include/star -D_SRC_='"no_source_available"' -DHAVE_CONFIG_H  -DTOOLBOX  -O  -s WASM=1 -s EXPORTED_FUNCTIONS="['_main']" -s MODULARIZE -s EXPORT_ES6  -s ENVIRONMENT='web'  -s EXPORTED_RUNTIME_METHODS='["FS","callMain"]' -s INVOKE_RUN=0 SeBa.C  -L. -ldstar -L../sstar -lsstar -L../node -lnode -L../node/dyn -ldyn -L../std -lstd -lm -o seba.js

cp seba.js $scriptdir/
cp seba.wasm $scriptdir/

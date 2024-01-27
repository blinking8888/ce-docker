#!/bin/sh

DEST_BASE=/opt/compiler-explorer/rust

file=$1
dir=$(dirname $file)

dest=$DEST_BASE/$dir/.
mkdir -p $dest
cp -r $file $dest

#!/usr/bin/env bash

TS=$(date +"%Y-%m-%d_%H-%M-%S")
CMD=

tar -cf master.tar ./*
gzip master.tar
rm archive/*
mv master.tar.gz archive

git add -A
git commit -m "makeArchive.$TS"
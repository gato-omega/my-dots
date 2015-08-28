#!/usr/bin/env bash

tar -cf master.tar ./*
gzip master.tar
rm archive/*
mv master.tar.gz archive
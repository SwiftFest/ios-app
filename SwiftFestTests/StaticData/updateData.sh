#!/bin/sh

BASEDIR=$(dirname "$0")
for filepath in "$BASEDIR"/*.json; do
    filename=$(basename $filepath)
    curl -v -o "$filepath" "http://swiftfest.io/$filename"
done

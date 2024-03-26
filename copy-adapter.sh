#!/bin/bash

mkdir -p ./content/adapters/storage
cp -r ./node_modules/ghost-storage-adapter-s3 ./content/adapters/storage/s3

mkdir ./content/adapters/storage/s3/node_modules
cp -r ./node_modules/* ./content/adapters/storage/s3/node_modules/.

rm -rf ./node_modules
rm package.json package-lock.json
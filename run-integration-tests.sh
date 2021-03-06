#!/bin/bash

set -e

SWIFT_VERSION=$(<.swift-version)

# Build Swift executable
docker run \
    --rm \
    --volume "$(pwd):/app" \
    --workdir /app \
    swift:$SWIFT_VERSION \
    swift build -c release --build-path .build/native
mkdir -p .build/lambda
cp .build/native/release/Lambda .build/lambda/

# Copy libraries necessary to run Swift executable
mkdir -p .build/lambda/libraries
docker run \
    --rm \
    --volume "$(pwd):/app" \
    --workdir /app \
    swift:$SWIFT_VERSION \
    /bin/bash -c "ldd .build/native/release/Lambda | grep so | sed -e '/^[^\t]/ d' -e 's/\t//' -e 's/.*=..//' -e 's/ (0.*)//' | xargs -i% cp % .build/lambda/libraries"

# Run integration tests
cp Shim/index.js .build/lambda/
docker run \
    --rm \
    --volume "$(pwd):/app" \
    --workdir /app/.build/lambda \
    --entrypoint node \
    lambci/lambda \
    -e 'var fs = require("fs");require("./").handler(JSON.parse(fs.readFileSync("../../session_start.json", "utf8")), {}, function(e, r) {if (e) {console.error(e);process.exit(1);} else {console.log(r);}});'

# Zip Swift executable, libraries and Node.js shim
cd .build/lambda
rm -f lambda.zip
zip -r lambda.zip *
cd ../..

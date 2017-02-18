#!/bin/bash

set -e

SWIFT_VERSION=$(<.swift-version)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

swift build
swift test
swift package generate-xcodeproj
"${DIR}/run-integration-tests.sh"

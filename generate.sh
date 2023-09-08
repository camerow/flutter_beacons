#!/bin/bash
set -e

# Download most recent `beacons.ttf`
pushd fonts/

printf "\nFetching beacons.ttf\n"

curl -s -O -L "https://raw.githubusercontent.com/cryptowatch/beacons/master/dist/beacons.ttf"

popd

printf "\nFetching beacons.json\n"
# Fetch the json variables to parse into IconData
curl -s -o /tmp/beacons.json "https://raw.githubusercontent.com/cryptowatch/beacons/master/dist/beacons.json"

# Parse json with generator and create the beacons library.
dart ./tools/generator.dart /tmp/beacons.json lib/beacons.g.dart

# Cleanup
rm /tmp/beacons.json
#!/bin/bash

set -e

mkdir -p ./build/kernel
cd ./build/kernel

repo init --depth=1 -u https://gitlab.hentaios.com/hentaios-gs-6.x/manifest -b Vallhound
echo "Repo initialized successfully!"
repo --version
echo "Begin repo sync..."
repo --trace sync -c -j$(nproc --all) --no-tags --fail-fast -v
echo "Repo sync done!"
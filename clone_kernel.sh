#!/bin/bash

set -e

mkdir -p ./builds/kernel
cd ./builds/kernel

repo init --depth=1 -u https://gitlab.hentaios.com/hentaios-gs-6.x/manifest.git/ -b Vallhound
echo "Repo initialized successfully!"
repo --version
echo "Begin repo sync..."
repo --trace sync -c --no-tags --fail-fast
echo "Repo sync done!"
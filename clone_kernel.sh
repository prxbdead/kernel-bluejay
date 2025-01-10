#!/bin/bash

set -e

# Ensure the repo tool is installed
if ! command -v repo &> /dev/null
then
    echo "repo command could not be found, please install repo first."
    exit 1
fi

mkdir -p ./builds/kernel
cd ./builds/kernel

# Initialize repo with the given manifest
echo "Initializing repo..."
repo init --depth=1 -u https://gitlab.hentaios.com/hentaios-gs-6.x/manifest.git/ -b Vallhound
echo "Repo initialized successfully!"

# Print repo version
repo --version

# Uncomment if SSH is required
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_ed25519

echo "Begin repo sync..."
# Sync the repo with additional verbosity and trace
repo --trace sync -c --no-tags --fail-fast -v
echo "Repo sync done!"
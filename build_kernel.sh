#!/bin/bash

set -e


# Check if 'builds' folder exists, create it if not
if [ ! -d "./builds" ]; then
    echo "'builds' folder not found. Creating it..."
    mkdir -p ./builds
else
    echo "'builds' folder already exists removing it."
    rm -rf ./builds
    mkdir -p ./builds
fi

cd ./builds

#git clone https://gitlab.com/simonpunk/susfs4ksu.git -b "gki-android14-6.1"

# git clone https://github.com/TheWildJames/kernel_patches.git

mkdir kernel
cd ./kernel

repo init --depth=1 -u https://gitlab.hentaios.com/hentaios-gs-6.x/manifest -b Vallhound
repo --trace sync -c -j$(nproc --all) --no-tags --fail-fast

#cd ./aosp
#curl -LSs "https://raw.githubusercontent.com/rifsxd/KernelSU-Next/next/kernel/setup.sh" | bash -

#cd ./KernelSU-Next/kernel
#sed -i 's/ccflags-y += -DKSU_VERSION=16/ccflags-y += -DKSU_VERSION=12000/' ./Makefile
#cd ../../

#cp ../../susfs4ksu/kernel_patches/KernelSU/10_enable_susfs_for_ksu.patch ./KernelSU-Next/
#cp ../../susfs4ksu/kernel_patches/50_add_susfs_in_gki-android14-6.1.patch ./
#cp ../../susfs4ksu/kernel_patches/fs/* ./fs/
#cp ../../susfs4ksu/kernel_patches/include/linux/* ./include/linux/

#cd ./KernelSU-Next
#patch -p1 --forward < 10_enable_susfs_for_ksu.patch || true
#cd ../
#patch -p1 < 50_add_susfs_in_gki-android14-6.1.patch || true
#cp ../../kernel_patches/69_hide_stuff.patch ./
#patch -p1 -F 3 < 69_hide_stuff.patch

cd ..

#echo "CONFIG_KSU=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_HAS_MAGIC_MOUNT=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_SUS_PATH=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_SUS_MOUNT=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_AUTO_ADD_SUS_KSU_DEFAULT_MOUNT=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_AUTO_ADD_SUS_BIND_MOUNT=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_SUS_KSTAT=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_SUS_OVERLAYFS=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_TRY_UMOUNT=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_AUTO_ADD_TRY_UMOUNT_FOR_BIND_MOUNT=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_SPOOF_UNAME=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_ENABLE_LOG=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_HIDE_KSU_SUSFS_SYMBOLS=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_SPOOF_CMDLINE_OR_BOOTCONFIG=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_OPEN_REDIRECT=y" >> ./aosp/arch/arm64/configs/gki_defconfig
#echo "CONFIG_KSU_SUSFS_SUS_SU=y" >> ./aosp/arch/arm64/configs/gki_defconfig

#sed -i '2s/check_defconfig//' ./aosp/build.config.gki
rm -rf ./aosp/android/abi_gki_protected_exports_aarch64
rm -rf ./aosp/android/abi_gki_protected_exports_x86_64

curl -L https://github.com/bazelbuild/bazel/releases/download/8.0.0/bazel-8.0.0-linux-x86_64 > tools/bazel

exec tools/bazel run \
    --lto=thin \
    --config=fast \
    --config=bluejay \
    //private/devices/google/bluejay:gs101_bluejay_dist "$@"

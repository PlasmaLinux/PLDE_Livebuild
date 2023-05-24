#!/bin/bash
#
# replace_version_description.sh 20230523
# 
# desc: 
#   os-release, grub, live-bootの情報をPLDE用に書き変えるスクリプト
#
# Written by aruelu, 2023/05/22
# Modify by rkarsnk, 2023/05/23
# Modify by aruelu, 2023/05/24


. ./VERSION

CHROOT_AFTER_DIR="config/includes.chroot_after_packages"
BOOTLOADERS_DIR="config/bootloaders"

sed -i -e "s#@PRETTY_NAME@#${DISTRO_NAME} ${DISTRO_VERSION} ${DISTRO_CODENAME}#g" \
    -e "s#@NAME@#${DISTRO_NAME}#g" \
    -e "s#@VERSION_ID@#${DISTRO_VERSION}#g" \
    -e "s#@VERSION_NAME@#${DISTRO_VERSION} ${DISTRO_CODENAME}#g" \
    ${CHROOT_AFTER_DIR}/lib/os-release

sed -i -e "s#@PRETTY_NAME@#${DISTRO_NAME} ${DISTRO_VERSION} ${DISTRO_CODENAME}#g" \
    ${CHROOT_AFTER_DIR}/etc/issue

sed -i -e "s#@PRETTY_NAME@#${DISTRO_NAME} ${DISTRO_VERSION} ${DISTRO_CODENAME}#g" \
    ${CHROOT_AFTER_DIR}/etc/issue.net

sed -i -e "s#@NAME@#${DISTRO_NAME}#g" \
    ${CHROOT_AFTER_DIR}/etc/default/grub

sed -i -e "s#@PRETTY_NAME@#${DISTRO_NAME} ${DISTRO_VERSION} ${DISTRO_CODENAME}#g" \
    ${BOOTLOADERS_DIR}/syslinux_common/splash.svg

sed -i -e "s#@PRETTY_NAME@#${DISTRO_NAME} ${DISTRO_VERSION} ${DISTRO_CODENAME}#g" \
    ${BOOTLOADERS_DIR}/grub-pc/live-theme/theme.txt

# Add by rkarsnk, 2023/05/23
sed -i -e "s#@PRETTY_NAME@#${DISTRO_NAME} ${DISTRO_VERSION} ${DISTRO_CODENAME}#g" \
    ${CHROOT_AFTER_DIR}/etc/grub.d/10_linux

# Add by aruelu, 2023/05/24
sed -i -e "s#@PRETTY_NAME@#${DISTRO_NAME} ${DISTRO_VERSION} ${DISTRO_CODENAME}#g" \
    -e "s#@NAME@#${DISTRO_NAME}#g" \
    -e "s#@VERSION_ID@#${DISTRO_VERSION}#g" \
    ${CHROOT_AFTER_DIR}/usr/share/calamares/branding/plasma/branding.desc

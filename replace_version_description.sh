#!/bin/bash
#Written by aruelu, 2023.05

. ./VERSION

CHROOT_AFTER_DIR="config/includes.chroot_after_packages"
BOOTLOADERS_DIR="config/bootloaders"

sed -i -e "s#@PRETTY_NAME@#${PRETTY_NAME}#g" \
    -e "s#@NAME@#${NAME}#g" \
    -e "s#@VERSION_ID@#${VERSION_ID}#g" \
    -e "s#@VERSION_NAME@#${VERSION_NAME}#g" \
    ${CHROOT_AFTER_DIR}/lib/os-release

sed -i -e "s#@PRETTY_NAME@#${PRETTY_NAME}#g" ${CHROOT_AFTER_DIR}/etc/issue
sed -i -e "s#@PRETTY_NAME@#${PRETTY_NAME}#g" ${CHROOT_AFTER_DIR}/etc/issue.net

sed -i -e "s#@PRETTY_NAME@#${PRETTY_NAME}#g" ${CHROOT_AFTER_DIR}/etc/default/grub

sed -i -e "s#@PRETTY_NAME@#${PRETTY_NAME}#g" ${BOOTLOADERS_DIR}/syslinux_common/splash.svg

sed -i -e "s#@PRETTY_NAME@#${PRETTY_NAME}#g" ${BOOTLOADERS_DIR}/grub-pc/live-theme/theme.txt


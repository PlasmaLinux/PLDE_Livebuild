#!/bin/bash
TIMESTAMP=`date +%Y%m%d`
IMAGE_NAME="PLDE_alpha1_${TIMESTAMP}"


lb config \
	--apt apt \
	--architecture amd64 \
	--distribution testing  \
	--parent-distribution testing \
	--parent-debian-installer-distribution testing \
	--archive-areas "main contrib non-free non-free-firmware" \
	--mirror-bootstrap "http://ftp.riken.go.jp/Linux/debian/debian" \
	--mirror-chroot "http://ftp.riken.go.jp/Linux/debian/debian" \
	--mirror-binary "http://ftp.riken.go.jp/Linux/debian/debian" \
	--bootappend-live "boot=live components locales=ja_JP.UTF-8 debug=1" \
	--image-name ${IMAGE_NAME}


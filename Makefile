IMAGE_NAME="PLDE_${VERSION}_`date +%Y%m%d`"
CHROOT_AFTER_DIR="config/includes.chroot_after_packages"
ROOTFS_RESOURCES="resources/rootfs"
PACKAGE_LISTS="config/package-lists"
PACKAGE_LISTS_RESOURCES="resources/package-lists"

include VERSION

# 1. LiveBuild時に参照するconfigディレクトリを作成する．
buildconfig:
	lb config \
	--apt apt \
	--architecture amd64 \
	--apt-recommends false \
	--distribution testing  \
	--parent-distribution testing \
	--parent-debian-installer-distribution testing \
	--archive-areas "main contrib non-free non-free-firmware" \
	--mirror-bootstrap "http://ftp.riken.go.jp/Linux/debian/debian" \
	--mirror-chroot "http://ftp.riken.go.jp/Linux/debian/debian" \
	--mirror-binary "http://ftp.riken.go.jp/Linux/debian/debian" \
	--bootappend-live "boot=live components username=plasma locales=ja_JP.UTF-8 debug=1" \
	--binary-image iso-hybrid \
	--image-name ${IMAGE_NAME}

	cp -pr ${ROOTFS_RESOURCES}/* ${CHROOT_AFTER_DIR}
	cp -pr ${PACKAGE_LISTS_RESOURCES}/* ${PACKAGE_LISTS}

# 2. squashfs用にdebootstrapにてベースパッケージを取得
bootstrap: buildconfig
	sudo lb bootstrap

# 3. squashfs環境に指定したパッケージとファイルを導入する
chroot: bootstrap
	sudo lb chroot

# 4. LiveImageを生成する
binary: chroot
	sudo lb binary

# 2.3.4のステップを一気に実行
build: buildconfig
	sudo lb build


clean:
	sudo lb clean
	rm -rf config local auto

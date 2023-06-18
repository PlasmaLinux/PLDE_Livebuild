# Debian Live Build について by rkarsnk
Debian Live Build は [Debian Live Project](https://salsa.debian.org/live-team/) が開発しているカスタムISOを作成するツールである．

# Debian Live Build を実際に使ってみる
## 準備
Debian 11がインストールされたPC上で以下のコマンドを実行し，Debian Live Buildの各種ツール郡をインストールします．

```
apt install live-build
```
次からは，実際にLive Build プロジェクトを作成していきます．

## Live Build プロジェクトの作成
以下のコマンドを実行することで，Live Build に必要な config ディレクトリが生成される．
```
$ mkdir live
$ cd live
$ lb config \
	--apt apt \
	--architecture amd64 \
	--apt-recommends false \
	--mirror-bootstrap "http://deb.debian.org/debian" \
	--mirror-chroot "http://deb.debian.org/debian" \
	--mirror-binary "http://deb.debian.org/debian" \
	--distribution bookworm  \
	--debian-installer live \
	--debian-installer-distribution bookworm \
	--archive-areas "main contrib non-free non-free-firmware" \
	--bootappend-live "boot=live components debug=1" \
	--image-name "Live-Image"
```
`lb config`で指定しているオプションの概要は，以下のとおり．

|オプション|値|概要|
|---|---|---|
| `--apt` | `apt`| 利用するパケッジ管理コマンド|
| `--architecture` | `amd64` | CPUアーキテクチャ|
| `--apt-recommends` | `false` | デフォルトは `true`．`false`にすると Recommendsに記載のパッケージのインストールは省略される．|
| `--mirror-bootstrap` | `"http://deb.debian.org/debian"` | `lb bootstrap` 処理時に利用するmirror |
| `--mirror-chroot` | `"http://deb.debian.org/debian"` | `lb chroot` 処理時に利用するmirror |
| `--mirror-binary` | `"http://deb.debian.org/debian"` | `lb binary` 処理時に利用するmirror |
| `--distribution` | `bookworm` | 作成するライブイメージのベースバージョン |
| `--debian-installer` | `live` | ライブイメージで起動する`debian-installer`を導入する．`live`のほかにも`cdrom\|netinst\|netboot\|businesscard\|none` が指定可能|
| `--debian-installer-distribution` | `bookworm` | Debian Installerのベースディストリビューション |
| `--archive-areas` | `"main contrib non-free non-free-firmware"` | apt で利用する archive の指定．bookwormでは，`non-free-firmware` も指定する|
| `--bootappend-live` | `"boot=live components debug=1"` | ライブイメージ用カーネルパラメータ|
| `--image-name` | `"Live-Image"` | 生成するカスタムISOのベースネーム|

上記のオプション指定で，Debian Bookworm ベースのカスタムISOのプロジェクトが作成できる．

## Live Build プロジェクトの編集
Debian Live Build のドキュメントである [Debian Live Manual](https://live-team.pages.debian.net/live-manual/html/live-manual/index.ja.html) によれば，
```
$ sudo lb build
```
を実行することで，カスタムISOがビルドできる．

~~ドキュメントに記載の内容に古い部分があるため，ライブ環境にログインできないカスタムISOが作成されてしまう．これはライブ環境を起動する際に，ライブ環境用ユーザを作成するブート時Hook処理が正しく実行できないことに起因する．この問題を解決するためには，ブート時フックで利用するコマンドuser-setupをライブイメージにインストールする必要がある．そのために，`lb config`で作成された`config`ディレクトリ以下のファイルを編集する．~~

`lb config` のオプションに `--apt-recommends false` を指定すると，ライブユーザを作成する際に実行する`user-setup`コマンドがインストールされない．本来，`user-setup` は `live-config` のRecommends パッケージとしてインスールされるが，Recommends を無効にしているため，別途 `user-setup` をインストールするように，プロジェクトの設定を変更する必要がある．その手順を以下で説明する．

以下に，`lb config`で生成された`config`ディレクトリの構造を示す．
```
config/
├── apt/
├── archives/
├── bootloaders/
├── debian-installer/
├── hooks/
│   ├── live/
│   └── normal/
├── includes/
├── includes.binary/
├── includes.bootstrap/
├── includes.chroot_after_packages/
├── includes.chroot_before_packages/
├── includes.installer/
├── includes.source/
├── package-lists/
│   └── live.list.chroot
├── packages/
├── packages.binary/
├── packages.chroot/
├── preseed/
├── rootfs/
├── binary
├── bootstrap
├── chroot
├── common
└── source
```
`package-lists`ディレクトリはパッケージ名を列挙したファイル(`*.chroot.list`)を配置することで，カスタムISOに指定したパッケージをインストールする．デフォルトでは，`live.list.chroot`ファイルのみが生成されている．

`live.list.chroot` の内容は以下のとおりである．
``` {live.list.chroot}
live-boot
live-config
live-config-systemd
systemd-sysv
```
上記の指定されたパッケージには，user-setupコマンド導入するパッケージが列挙されていないため，以下のように修正する必要がある．

``` {live.list.chroot}
live-boot
live-config
live-config-systemd
systemd-sysv
user-setup
```
このように修正することで，user-setupがインストールされたカスタムISOが生成できる．

## お好みの環境をカスタムISOにインストールする
上記の設定のままでは，GNOMEやmateなどのデスクトップ環境はインストールされない．これらの環境をインストールするためには，追加の設定を行なう必要がある．

まずは，Debianで標準的に利用されているパッケージをインストールするために，`package-lists/standard.chroot.list` を作成する．
``` {standard.chroot.list}
apt-listchanges
bash-completion
bind9-dnsutils
bind9-host
bzip2
ca-certificates
dbus
debian-faq
doc-debian
file
gettext-base
groff-base
inetutils-telnet
krb5-locales
libc-l10n
liblockfile-bin
libnss-systemd
libpam-systemd
locales
lsof
man-db
manpages
media-types
mime-support
ncurses-term
netcat-traditional
openssh-client
pciutils
perl
python3-reportbug
reportbug
systemd-timesyncd
traceroute
ucf
util-linux-extra
wamerican
wget
xz-utils
```
このファイルは以下のように書くこともできる．

``` {standard.chroot.list}
! Packages Priority standard
```

次にGUIデスクトップ環境を導入する `package-lists/desktop.chroot.list` を作成する．
```
task-japanese

gnome-core
gnome-tweaks
gnome-shell-extensions
gnome-shell-extension-manager
gnome-shell-extension-kimpanel

gdm3
fonts-noto

fcitx5
fcitx5-skk
fcitx5-config-qt
```
上の例では，日本語環境/GNOME/GDM3/Notoフォント/Fcitx5関連のパッケージを列挙してある．


## いざビルド
実際に，GNOME環境のLiveカスタムISOを作成します．
```
sudo lb build
```
内部処理でdebootstrapでベースパッケージを取得後，chroot環境を構築し，指定したパッケージがインストールされ，カスタムISOで利用するsquashfsが生成され，最後にISOが作成される．上記の設定では，`Live-Image-amd64.hybrid.iso` という名前のISOが生成される．

# まとめ
本記事では，Debian Live Buildを使用したカスタムISO作成の方法について説明した．この時点では，ライブイメージもインストールされた環境も，**Debian**のままであり，フレーバ版とは言えない．フレーバ版を作成するには，更にカスタムスクリプトを追加したり，デスクトップ環境のテーマを設定する必要がある．

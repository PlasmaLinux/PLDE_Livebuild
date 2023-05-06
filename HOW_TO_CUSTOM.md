# How to custom PLDE
PLDE_LiveBuildは，Debian Live Buildを利用している．
PLDE独自のファイルは全て`resources`ディレクトリで管理しており，`make buildconfig`時に`lb config`で作成される`config`ディレクトリに必要なファイルをコピーしている．

# resources ディレクトリ構造
resources ディレクトリの構造は以下のようになっている．
```
resources
├── package-lists
├── rootfs
│   ├── etc
│   │   └── skel
│   ├── lib
│   │   └── live
│   │       ├── config
│   │       └── plasma
│   └── usr
│       ├── bin
│       └── share
│           ├── calamares
│           │   ├── branding
│           │   │   └── plasma
│           │   └── modules
│           └── plasmalinux
├── themes
└── user_config
    ├── autostart
    ├── plank
    │   └── dock1
    │       └── launchers
    └── xfce4
        └── xfconf
            └── xfce-perchannel-xml
```

- `package-lists` ディレクトリ
  - Liveイメージにインストールするパッケージのリストが配置されている．
  - `live.list.chroot`は編集禁止．何か追加したいパッケージがある場合は，`desktop.list.chroot` に追記する．

- `rootfs` ディレクトリ
  - Liveイメージのsquashfsに組み込みたいファイルが配置されている．`rootfs`ディレクトリ内は，squashfsの配置するディレクトリ構造に基づいてファイルを配置することが，ビルド時にビルド用chrootにコピーされる．
  - `rootfs/lib/live/config` はLiveイメージ特有のディレクトリで，Liveイメージ起動時に実行するシェルスクリプトが配置されている．PLDEでは，Liveユーザのデスクトップ上に，calamaresインストーラのランチャーを配置するスクリプトを追加している．

- `themes` ディレクトリ
  - [PlasmaLinux/PlasmaLinux_Themes](https://github.com/PlasmaLinux/PlasmaLinux_Themes) をsubmoduleとして取りこんでいる．

- `user_config` ディレクトリ
  - `/etc/skel/.config`の雛方となるファイルを配置
  - PLDE では，xfce4のテーマ壁紙の設定ファイルがあらかじめ作成している．

# カスタム方法
基本的に上記の`resouces` ディレクトリに必要なファイルを追加・編集することでカスタマイズできる．

PLDE固有の設定などを追加する場合は，`rootfs/usr/share/plasmalinux`以下に配置し，`/etc/profile.d`以下のスクリプトから実行するなどの工夫が必要．
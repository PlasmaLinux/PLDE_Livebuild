# PLDE_Livebuild
## 概要
Plasma Linux Debian Edition 開発用レポジトリ

**特徴**
- Debian testingベース
- Linux kernel 6.1.0-X
- Xfce 4.18
- Calamares 3.2.61

## 注意
なお，このリポジトリでビルドしたISOは，仮想マシン(UEFI,64bit，SecureBoot無効)の環境でのみでしか動作確認できておりません．
実機や本番環境で利用する場合は，事前に大事なデータのバックアップを取るなどの対策をとってください．

## ISOのビルド方法
### 必要な環境
Debian 11以上がインストールされたamd64(x86_64)PC．Debian testing (bookworm) を推奨

### 事前に必要なソフトウェア
以下のパッケージを事前にインストール
- git
- live-build

### ビルド方法
ビルド手順は以下のとおり．
```
git clone https://github.com/PlasmaLinux/PLDE_Livebuild.git BuildISO
cd BuildISO/livebuild
sudo lb clean
./prep.sh
sudo lb build
```
`PLDE-alpha1_YYYYMMDD-amd64.hybrid.iso`というファイルが生成されます．
LiveImageのユーザ名は`user`，パスワードは`live`です．

------
## TODO
- [x] Calamares インストーラの導入
- [ ] Makefileを使ったビルドシステム
- [ ] livebuildディレクトリの説明追加

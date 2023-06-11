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

## ディレクトリツリー

## ISOのビルド方法
### 必要な環境
Debian 11以上がインストールされたamd64(x86_64)PC．Debian testing (bookworm) を推奨

### 事前に必要なソフトウェア
以下のパッケージを事前にインストール
- git
- make
- live-build

### ビルド方法
ビルド手順は以下のとおり．
```
git clone --recursive https://github.com/PlasmaLinux/PLDE_Livebuild.git BuildISO
cd BuildISO/
make iso
```
`PLDE-alpha1_YYYYMMDD-amd64.hybrid.iso`というファイルが生成されます．
LiveImageのユーザ名は`plasma`，パスワードは`live`です．

### カスタム方法
- [HOW TO CUSTOM](HOW_TO_CUSTOM.md)

------
## TODO
- [x] Calamares インストーラの導入
- [x] Makefileを使ったビルドシステム
- [x] PlasmaLinuxのテーマ・アイコンをLiveイメージに適用する
- [ ] デフォルトの壁紙を変更する

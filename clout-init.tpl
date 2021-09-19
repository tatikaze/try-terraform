#cloud-config

runcmd:
# ホスト名の変更
  - hostnamectl set-hostname try-hurin-web

# パッケージのインストール
## セキュリティ関連の更新のみがインストール
  - yum update --security -y

# mysql client install
	- rpm -Uvh https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
	- yum install -y mysql-community-client.x86_64

# タイムゾーン変更
## 設定ファイルのバックアップ
  - cp  -p /etc/localtime /etc/localtime.org

## シンボリックリンク作成
  - ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

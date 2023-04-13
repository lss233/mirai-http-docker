#!/bin/bash

MCL_VERSION=ce4ab47
# Exit if any error occured
set -euxo pipefail


wget "https://github.com/iTXTech/mcl-installer/releases/download/${MCL_VERSION}/mcl-installer-${MCL_VERSION#v}-linux-amd64-musl" -O ./mcl-installer

chmod +x ./mcl-installer

mkdir app && cd app
# 安装临时的 fix-protocol-version 插件
mkdir plugins
wget https://github.com/cssxsh/fix-protocol-version/releases/download/v1.3.0/fix-protocol-version-1.3.0.mirai2.jar -O plugins/fix-protocol-version-1.3.0.mirai2.jar
wget https://github.com/MrXiaoM/mirai-console-dev-qrlogin/releases/download/0.1.1/mirai-console-dev-qrlogin-0.1.1.jar -O plugins/mirai-console-dev-qrlogin-0.1.1.jar

"../mcl-installer" << EOF
N
Y
EOF

chmod +x ./mcl

./mcl --update-package net.mamoe:mirai-console --channel     maven-prerelease
./mcl --update-package net.mamoe:mirai-core-all --channel maven-prerelease
./mcl --update-package net.mamoe:mirai-console-terminal --channel maven-prerelease
./mcl --update-package net.mamoe:mirai-api-http --channel stable-v2 --type plugin
./mcl --update-package xyz.cssxsh.mirai:mirai-device-generator --channel stable --type plugin
./mcl --boot-only
./mcl --dry-run
./mcl << EOF
exit
EOF

tree -d ../app

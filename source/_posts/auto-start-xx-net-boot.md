---
layout: new
title: Fedora 开机自动启动 XX-Net
tags: '-fedora'
categories: linux
date: 2018-05-12 01:12:26
---


本文记录 [XX-Net](http://localhost:4000/2016/02/04/latest-free-vpn/) 开机自动启动的设置。

<!-- more -->

# 关联服务脚本

进入 `/etc/init.d`

```bash
cd /etc/init.d
sudo ln -s /home/yourName/XX-Net/xx_net.sh xx_net'
```

# 开启服务并设置开机自动启动

```bash
sudo systemctl start xx-net
sudo systemctl enable xx-net
```

# 参考资料

* [https://github.com/XX-net/XX-Net/wiki/在Linux下如何将XX-Net作为后台服务启动](https://github.com/XX-net/XX-Net/wiki/在Linux下如何将XX-Net作为后台服务启动)

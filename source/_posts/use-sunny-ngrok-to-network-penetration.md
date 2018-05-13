---
layout: new
title: 使用 sunny-ngrok 做内网穿透
tags:
  - network penetration
categories: operation
date: 2018-05-14 02:13:43
---


本文记录如何使用 [sunny-ngrok](https://www.ngrok.cc/) 做内网穿透。

<!-- more -->

# 搭建内网服务器

假设在内网 `http://192.168.1.12` 搭建了 Gitlab 服务器

![gitlab](./gitlab.png)

# 注册 sunny-ngrok 并开通免费隧道

Gitlab 网站需要一个 http 协议隧道，ssh 需要一个 tcp 协议隧道

* [开通 http 协议隧道](https://www.sunnyos.com/article-show-67.html)
* [开通 tcp 协议隧道](https://www.sunnyos.com/article-show-70.html)

![tunnels](./tunnels.png)

# 下载客户端并启动脚本

* [Windows 中使用 sunny-ngrok 脚本](https://www.sunnyos.com/article-show-71.html)

![monitor](./monitor.png)

# 测试结果

外网域名为 [http://pregitlab.free.ngrok.cc](http://pregitlab.free.ngrok.cc)

## 网站

![website](./website.png)

## SSH 连接

> 注意 `.ssh/config` 中的相关配置
> ```bash
> # gitlab
> Host pregitlab.free.ngrok.cc
>   HostName pregitlab.free.ngrok.cc
>   Port 11273
>   PreferredAuthentications publickey
>   IdentityFile /home/tlj/.ssh/id_rsa.gitlab
> ```

![ssh](./ssh.png)


# 参考资料

* [https://www.sunnyos.com/](https://www.sunnyos.com/)

---
layout: new
title: Fedora 系统中安装 Gitlab
tags:
  - fedora
categories: linux
date: 2018-05-06 13:39:40
---


Gitlab 是一个为了完成 [DevOps](https://zh.wikipedia.org/wiki/DevOps) 工作流的单应用程序。本文记录如何在 Fedora 系统中安装 Gitlab。

<!-- more -->

# 准备工作

## 硬件环境

* 双核 CPU + 2 GB 内存

## 需要模块

* 安装 curl 用于下载文件
* 安装 openssh-server 用于 ssh 连接
* 安装 ca-certificates 用于添加 CA 认证
* 安装 postfix 用于 MTA

```bash
sudo dnf install curl openssh-server ca-certificates postfix
```

## 启动 postfix 服务

```bash
sudo systemctl start sshd postfix
```

设置开机启动

```bash
sudo systemctl enable sshd postfix
```

# 安装 Gitlab

## 下载安装包

[https://packages.gitlab.com/gitlab/gitlab-ce?filter=rpms](https://packages.gitlab.com/gitlab/gitlab-ce?filter=rpms)

## 安装

```bash
duso dnf install <path>/gitlab<version-num>.rpm
```

## 初始化 Gitlab

```bash
sudo gitlab-ctl reconfigure
```

## 设置防火墙

```bash
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload
```

## 打开 Gitlab

![screenshot](./screenshot.png)

# 参考资料

* [https://linoxide.com/linux-how-to/install-gitlab-on-ubuntu-fedora-debian/](https://linoxide.com/linux-how-to/install-gitlab-on-ubuntu-fedora-debian/)

---
title: Windows 下的包管理工具 chocolatey
categories: package-manager
tags: chocolatey
date: 2016-07-30 14:50:14
updated: 2016-07-30 14:50:14
---

**[Chocolatey](https://chocolatey.org/)** 是 Windows 下的自动化软件管理工具，当然它是开源的。
<!--more-->

## 安装 Chocolatey

安装 Chocolatey 非常简单 `WIN+X+A` 使用管理员打开 cmd 终端，复制下面的命令并执行

```bash
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
```

检查 Chocolatey 已正确安装

```bash
choco -v
```
![Installation](./installation.png 'Installation')

## 寻找想要的包

Chocolatey 已经安装好了，那么开始我们的包管理之旅吧，先去找找你需要的包吧，**[戳这里](https://chocolatey.org/packages)**

## 参考资料

* **[https://chocolatey.org](https://chocolatey.org/)**

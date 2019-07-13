---
title: Windows Terminal
tags:
  - terminal
categories: windows
date: 2019-07-14 03:22:39
---


Windows Terminal 的采坑记录

<!-- more -->

# Windows Terminal

![](https://note.youdao.com/yws/res/40879/WEBRESOURCE2cc7445ad871398ee0d0e25c6cff79c9)

Windows Terminal 是一个全新的、流行的、功能强大的命令行终端工具。包含很多来社区呼声很高的特性，例如：多 Tab 支持、富文本、多语言支持、可配置、主题和样式，支持 emoji 和基于 GPU 运算的文本渲染等等

同时该终端依然符合我们的目标和要求，以确保它保持快速、高效，并且不会消耗大量内存和电源

## 安装 Windows Terminal

我们可以通过 Microsoft Store 安装 Windows Terminal，也可以通过官方仓库手动编译 Windows Terminal。我推荐在 Microsoft Store 安装，因为这种方式最方便 (1)

![](https://note.youdao.com/yws/res/40882/WEBRESOURCE04db151182ac44c730bb8844cdcd0cd6)

## WSL

Windows Subsystem for Linux(简称 WSL) 是一个在 Windows 10 上能够运行原生 Linux 二进制可执行文件 (ELF 格式) 的兼容层。它是由微软与 Canonical 公司合作开发，其目标是使纯正的 Ubuntu 14.04 "Trusty Tahr" 映像能下载和解压到用户的本地计算机，并且映像内的工具和实用工具能在此子系统上原生运行 (2)

### 开启 WSL 功能

进入控制面板，添加程序功能 `Windows Subsystem for Linux` 并重启电脑

![](http://note.youdao.com/yws/res/40801/WEBRESOURCEa19c7045a57983056a9520e2c8dc2e10)

### 安装 Ubuntu

那么我们以 Ubuntu 为例，来演示如何在 Windows 10 中运行 Linux 系统，同样我们在 Microsoft Store 安装 Ubuntu

![](https://note.youdao.com/yws/res/40886/WEBRESOURCE715164236db17c4ea74102e2496df178)

## 配置 WT

在 WT 的 Tab 下拉菜单中选择 Setting，打开 profiles.json (3)

![](https://note.youdao.com/yws/res/40891/WEBRESOURCEb19818d4a22d3e5bd74ecfb7f4889097)

添加关于 Ubuntu 的配置

```json
{
    "acrylicOpacity" : 0.75,
    "closeOnExit" : true,
    "colorScheme" : "One Half Dark",
    "commandline" : "ubuntu.exe",
    "cursorColor" : "#FFFFFF",
    "cursorShape" : "bar",
    "fontFace" : "Consolas",
    "fontSize" : 14,
    "guid" : "{f36bcc90-c0a1-48fb-9a11-6b1099c060a2}",
    "historySize" : 9001,
    "icon" : "ms-appdata:///Roaming/{f36bcc90-c0a1-48fb-9a11-6b1099c060a2}.png",
    "name" : "Ubuntu",
    "padding" : "0, 0, 0, 0",
    "snapOnInput" : true,
    "startingDirectory" : "%USERPROFILE%",
    "useAcrylic" : true
}
```

![](https://note.youdao.com/yws/res/40894/WEBRESOURCE4f0b2914c1a561aa9d55d60c4d6176af)

> 注意：guid 需要在 PowerShell 中执行 `new-guid` 命令

```bash
new-guid
```

![](https://note.youdao.com/yws/res/40897/WEBRESOURCEaa41ae3999442614806853940feeec62)

## WT 相关资源存储路径

`profiles.json` 存放在 `$env:LocalAppData\Packages\Microsoft.WindowsTerminal_<randomString>\RoamingState\profiles.json`(对应 ms-appdata:///Roaming/)，官方建议配置资源都存放到 `RoamingState` 目录，方便管理维护，即与 `profiles.json` 同级目录中，例如上面 Ubuntu 的 `icon` 配置项 `ms-appdata:///Roaming/{f36bcc90-c0a1-48fb-9a11-6b1099c060a2}.png`

## 参考资料

* [https://github.com/microsoft/terminal/blob/master/doc/user-docs/index.md](https://github.com/microsoft/terminal/blob/master/doc/user-docs/index.md) (1)
* [https://baike.baidu.com/item/wsl/20359185?fr=aladdin#1](https://baike.baidu.com/item/wsl/20359185?fr=aladdin#1) (2)
* [https://github.com/microsoft/terminal/blob/master/doc/cascadia/SettingsSchema.md](https://github.com/microsoft/terminal/blob/master/doc/cascadia/SettingsSchema.md) (3)
* [https://github.com/microsoft/terminal/blob/master/doc/user-docs/UsingJsonSettings.md](https://github.com/microsoft/terminal/blob/master/doc/user-docs/UsingJsonSettings.md) (3)

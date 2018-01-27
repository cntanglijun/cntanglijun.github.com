---
title: npmrc 中使用相关国内镜像
tags:
  - npm
categories: nodejs
date: 2018-01-27 22:56:26
---


国内使用 npm 安装模块很慢，而且往往出现连接超时、安装失败等问题。通过实践，我们可以在项目中创建 `.npmrc` 文件配置相关的国内镜像来加速安装。

<!--more-->

# .npmrc

```
phantomjs_cdnurl = https://npm.taobao.org/mirrors/phantomjs/
electron_mirror = https://npm.taobao.org/mirrors/electron/
registry = https://registry.npm.taobao.org
strict-ssl = false
```

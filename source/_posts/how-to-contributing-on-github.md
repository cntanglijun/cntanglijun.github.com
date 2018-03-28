---
title: 如何在 Github 社区团队开发
tags: github
categories: git
date: 2016-03-23 15:51:06
---


Github 是一个庞大的开源社区，上面有许许多多优秀的开源项目。

本文简单介绍如何在 github 参与项目，并贡献自己的代码

<!--more-->

## 发现好的项目时，fork it

![fork-it](fork-it.jpg)

## 克隆项目到本地

```shell
git clone git@github.com:<userName>/<projectName>.git
```

## 创建分支

```shell
git checkout -b your-new-feature
```

## 提交更改

```shell
git commit -a -m 'add some feature'
```

## 提交分支到仓库

```shell
git push origin your-new-feature
```

## 提交 pull request

![pull-request](pull-request.jpg)

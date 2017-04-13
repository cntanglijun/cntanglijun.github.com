---
title: git 命令之 init
categories: git
tags: command
date: 2016-01-25 17:38:38
---

创建一个新的 **Git** 仓库或重新初始化一个已存在的 **Git** 仓库我们使用 **git init** 命令
<!--more-->

## **git init** 基本用法

### 当前目录中初始化

假设我的项目目录为 **proj1**

```bash
cd proj1
```

![1_1](./images/1_1.jpg '1_1')

先进入项目目录，然后运行 **git init**

```bash
git init
```

![1_2](./images/1_2.jpg '1_2')

初始化成功后，项目目录中会生成 **.git** 目录，用户存放 **git** 信息和文件

![1_3](./images/1_3.jpg '1_3')

### 指定目录初始化

假设在 **D** 盘中有 **proj2** 而当前目录在 **D** 盘根，那么我们可以指定目录初始化 **git** 仓库

```bash
git init proj2
```

![1_4](./images/1_4.jpg '1_4')

我们进入 **proj2** 查看是否初始化成功

![1_5](./images/1_5.jpg '1_5')
![1_6](./images/1_6.jpg '1_6')

## **git init** 更多用法

查看 **git init** 的更多用法，我们使用只需要在命令后面加上参数 **&minus;h**

```bash
git init -h
```

![2_1](./images/2_1.jpg '2_1')

## 有关资料

* **[git官方文档-----git-init命令](http://git-scm.com/docs/git-init 'git-init')**

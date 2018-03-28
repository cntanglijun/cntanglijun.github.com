---
title: git 命令之 clone
categories: git
tags: command
date: 2016-01-26 14:00:41
---

克隆仓库到新的目录，使用 **git clone** 命令
<!--more-->

## 基本用法

### 默认克隆

假设我们想克隆 **jquery** 仓库

```bash
git clone git@github.com:jquery/jquery.git
```

![1_1](./images/1_1.jpg '1_1')

### 自定义目录名

如果你想指定目录可以在命令后面跟上目录名

```bash
git clone git@github.com:jquery/jquery.git jq
```

![1_2](./images/1_2.jpg '1_2')

### 克隆分支

克隆分支，需要在命令后跟参数 **&minus;&minus;branch** 或者 **&minus;b**

```bash
git clone git@github.com:jquery/jquery.git -b 2.2-stable jq2.2
```

![1_3](./images/1_3.jpg '1_3')

## 更多用法

查看更多 **git clone** 参数用法，可以使用 **&minus;h**

```bash
git clone -h
```

![2_1](./images/2_1.jpg '2_1')

## 参考资料

* **[git官方文档-----git-clone命令](http://git-scm.com/docs/git-clone 'git官方文档-----git-clone命令')**

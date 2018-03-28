---
title: git 命令之 status
categories: git
tags: command
date: 2016-01-29 11:55:56
---

**git status** 命令用于查看当前仓库的文件状态
<!--more-->

## 基本用法

### 不带参数

```bash
git status
```

![1_1](./images/1_1.jpg '1_1')

### 简短格式

简短格式我们使用参数 **&minus;s** 或 **&minus;&minus;short**

```bash
git status -s
```

![1_2](./images/1_2.jpg '1_2')

### 分支信息

显示分支信息(包括简短格式)使用参数 **&minus;b** 或 **&minus;&minus;branch**

```bash
git status -b
```

![1_3](./images/1_3.jpg '1_3')

### 详细信息

查看详细信息可以使用参数 **&minus;v** 或 **&minus;&minus;verbose**

```bash
git status -v
```

![1_4](./images/1_4.jpg '1_4')

### 查看忽略的文件

需要查看忽略的文件使用参数 **&minus;&minus;ignored**

```bash
git status --ignored
```

![1_5](./images/1_5.jpg '1_5')

## 更多用法

我们使用参数 **&minus;h** 查看更多用法

```bash
git status -h
```

![2_1](./images/2_1.jpg '2_1')

也可以使用如下命令，它会调用系统默认浏览器显示文档内容

```bash
git help status
```

![2_2](./images/2_2.jpg '2_2')
![2_3](./images/2_3.jpg '2_3')

## 参考资料

* **[git官方文档-----git-add命令](http://git-scm.com/docs/git-status 'git官方文档-----git-add命令')**

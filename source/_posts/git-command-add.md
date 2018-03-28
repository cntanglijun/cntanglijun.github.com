---
title: git 命令之 add
categories: git
tags: command
date: 2016-01-27 09:50:27
---


每次提交前，我们都需要使用 **git add** 命令把需要提交的文件放到暂存区

<!--more-->

## 常用命令

### 暂存单文件

暂存文件我们使用 **git add** 后面跟上文件名

```bash
git add README.md
```

![1_1](./images/1_1.jpg '1_1')

### 暂存所有文件

一次性暂存所有文件，使用参数 **&minus;A** 或 **&minus;&minus;all** 或 **&minus;&minus;no-ignore-removal**

```bash
git add -A
```

![1_2](./images/1_2.jpg '1_2')

### 暂存已跟踪的文件

如果不想暂存未跟踪的文件，命令后面加上参数 **&minus;u** 或 **&minus;&minus;update**

![1_3](./images/1_3.jpg '1_3')

### 暴力暂存

暂存所有文件，包括.gitignore中的文件，使用参数 **&minus;f** 或 **&minus;&minus;force**

![1_4](./images/1_4.jpg '1_4')

### 模拟暂存

如果你只是想看看这个文件是否可以暂存，可以使用参数 **&minus;n** 或 **&minus;&minus;dry-run**。实际上并不会真正暂存

```bash
git add -A -n
```

![1_5](./images/1_5.jpg '1_5')

### 显示暂存明细

如果想查看暂存明细，可以使用参数 **&minus;v** 或 **&minus;&minus;verbose**

```bash
git add -A -v
```

![1_6](./images/1_6.jpg '1_6')

## 更多用法

查看 **git add** 更多的用法，使用参数 **&minus;h**

```bash
git add -h
```

![2_1](./images/2_1.jpg '2_1')

## 参考资料

* **[git官方文档-----git-add命令](http://git-scm.com/docs/git-add 'git官方文档-----git-add命令')**

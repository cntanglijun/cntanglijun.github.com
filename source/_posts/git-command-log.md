---
title: git 命令之 log
tags: command
categories: git
date: 2016-02-02 14:12:59
---

查看 **git** 提交的信息日志，使用命令 **git log**
<!--more-->

## 语法

```shell
git log [<options>] [<revision range>] [[\--] <path>…​]
```

## 基础用法

### 限制输出日志数目

```shell
git log -<number>|-n <number>|--max-count=<number>
```

![max-num](max-num.jpg)

### 跳过前x条日志

```shell
git log --skip=<number>
```

![skip-num](skip-num.jpg)

### 显示log size

```shell
git log --log-size
```

![log-size](log-size.jpg)

### 显示source

```shell
git log --source
```

![source](source.jpg)

### 显示所有更改

```shell
git log --full-diff -p <path>
```

![full-diff](full-diff.jpg)

## 更多用法

```bash
git log -h
```

![2_1](2_1.jpg '2_1')

或者查看帮助文档

```bash
git help log
```

![2_2](2_2.jpg '2_2')
![2_3](2_3.jpg '2_3')

## 参考资料

* **[git官方文档-----git-log命令](http://git-scm.com/docs/git-log 'git官方文档-----git-log命令')**

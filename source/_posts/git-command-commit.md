---
title: git 命令之 commit
categories: git
tags: command
date: 2016-01-29 17:40:58
---

**git commit** 命令用于将已暂存的文件存储到 **git** 仓库
<!--more-->

## 基础用法

### 不带参数提交

```bash
git commit
```

**git** 会调用系统默认编辑器(或者调用你自己 **[配置](http://localhost:4000/2016/01/22/git-command-config/#配置文本编辑器)** 的编辑器)

![1_1](./images/1_1.jpg '1_1')

敲击键盘 **i** 键，进入编辑状态，输入提交信息

![1_2](./images/1_2.jpg '1_2')

然后按键盘左上角的 **Esc** 键退出编辑状态，输入 **:wq** 保存并退出编辑器

![1_3](./images/1_3.jpg '1_3')
![1_4](./images/1_4.jpg '1_4')

### 提交所有已跟踪的文件

提交所有已跟踪的文件(不包括未跟踪的文件)，使用参数 **&minus;a** 或 **&minus;&minus;all**

```bash
git commit -a
```

![1_5](./images/1_5.jpg '1_5')
![1_6](./images/1_6.jpg '1_6')

### 查看差异

提交时想查看一下文件差异，可以使用 **&minus;v** 或 **&minus;&minus;verbose** 参数

```bash
git commit -a -v
```

![1_11](./images/1_11.jpg '1_11')

### 命令行中输入提交信息

如果觉得上面操作太复杂。没关系！我们可以使用参数 **&minus;m** 或 **&minus;&minus;message**

```bash
git commit -a -m 'your commit message'
```

![1_7](./images/1_7.jpg '1_7')

### 查看可提交信息

使用参数 **&minus;&minus;dry&minus;run**

```bash
git commit --dry-run
```

![1_8](./images/1_8.jpg '1_8')

太长？没关系，有 **&minus;&minus;short**

```bash
git commit --dry-run --short
```

![1_9](./images/1_9.jpg '1_9')

**&minus;&minus;short** 后还可以跟 **&minus;&minus;branch** 显示当前分支

```bash
git commit --dry-run --short --branch
```

![1_10](./images/1_10.jpg '1_10')

## 更多用法

我们使用在命令后跟上参数 **&minus;h** 查看更多关于 **git commit** 的用法

```bash
git commit -h
```

![2_1](./images/2_1.jpg '2_1')

或者使用 **git help commit** 命令

```bash
git help commit
```

![2_2](./images/2_2.jpg '2_2')
![2_3](./images/2_3.jpg '2_3')

## 参考资料

* **[git官方文档-----git-commit命令](http://git-scm.com/docs/git-commit 'git官方文档-----git-commit命令')**

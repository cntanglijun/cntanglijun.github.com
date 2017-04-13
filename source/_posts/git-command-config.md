---
title: git 命令之 config
categories: git
tags: command
date: 2016-01-22 13:14:55
---

一般在新的系统上，我们都需要先配置下自己的 **Git** 工作环境。配置工作只需一次，以后升级时还会沿用现在的配置。当然，如果需要，你随时可以用相同的命令修改已有的配置。
<!--more-->

## 配置文件

**Git** 提供了一个叫做 **git config** 的工具(实际是 **git-config** 命令，只不过可以通过 **git** 加一个名字来呼叫此命令。)，专门用来配置或读取相应的工作环境变量。而正是由这些环境变量，决定了 **Git** 在各个环节的具体工作方式和行为。这些变量可以存放在三个不同的地方：

1. **/etc/gitconfig** 文件：系统中对所有用户都普遍适用的配置。若使用 **git config** 时用 **&minus;&minus;system** 选项，读写的就是这个文件。
2. **~/.gitconfig** 文件：用户目录下的配置文件只适用于该用户。若使用 **git config** 时用 **&minus;&minus;global** 选项，读写的就是这个文件。
3. 当前项目的 **git** 目录中的配置文件(也就是工作目录中的 **.git/config** 文件)：这里的配置仅仅针对当前项目有效。每一个级别的配置都会覆盖上层的相同配置，所以 **.git/config** 里的配置会覆盖 **/etc/gitconfig** 中的同名变量。

在 **Windows** 系统上，**Git** 会找寻用户主目录下的 **.gitconfig** 文件。主目录即 **$HOME** 变量指定的目录，一般都是 **C:\Documents and Settings\$USER**。此外，Git 还会尝试找寻 **/etc/gitconfig** 文件，只不过看当初 **Git** 装在什么目录，就以此作为根目录来定位。

## 配置用户信息

### 配置用户名

```bash
git config --global user.name 'ryuu'
```

### 配置邮箱

```bash
git config --global user.email 'ryuu@123.com'
```

用户名和邮箱是必须配置的，用于说明是谁提交了更新。如果只需要在当前项目中配置，只需要去掉 **&minus;&minus;global** 。

## 配置文本编辑器

输入提交信息时 **Git** 会自动调用一个外部编辑器，默认使用操作系统指定的默认编辑器，一般是 **Vi** 或 ** Vim ** 。如果你喜欢 **Emacs**，我们也可以配置

```bash
git config --global core.editor emacs
```

## 配置差异分析工具

解决合并冲突时，我们会用到差异分析工具。比如要改用 **vimdiff**：

```bash
git config --global merge.tool vimdiff
```

**Git** 可以理解 **kdiff3**，**tkdiff**，**meld**，**xxdiff**，**emerge**，**vimdiff**，**gvimdiff**，**ecmerge** 和 **opendiff** 等合并工具的输出信息

## 查看配置信息

### 查看所有信息

```bash
git config --list
```

可能会有重复的变量名，说明它们来自不同文件(**/etc/gitconfig** 和 **~/.gitconfig**)，**Git** 实际采用最后一个

### 查看指定信息

```bash
git config user.name
```

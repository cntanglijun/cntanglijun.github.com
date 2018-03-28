---
title: 配置多个 ssh key
categories: git
tags: ssh-key
date: 2016-04-06 00:21:04
---

有时候我们需要在一台电脑配置多个 **ssh key**，用于支持不同的 `git` 的平台或者在同一 `git` 平台使用几种不同的 **ssh key**
<!--more-->

## 什么是 ssh

参考百度百科的说明 **[点这里](http://baike.baidu.com/link?url=XjSCHYqkK3WP_a5tECSUPPVkXU12Ri8ILgyMnwHGO9jUtdJmXcW8kSpzlzd7Mps1CtE6DLNGPEclbm1aDhnHcK)**

## 如何生成 ssh key

如何生成 **ssh key** 这里不做介绍，请查看 **[https://help.github.com/articles/generating-an-ssh-key/](https://help.github.com/articles/generating-an-ssh-key/)**

## 默认的 ssh key

默认的 **ssh key** 记录在这里

![default-ssh-key](default-ssh-key.jpg)

## 生成不同的 ssh key

与生成 ssh key 相同，区别在于这里

![generate-other-ssh-key](generate-other-ssh-key.jpg)

![other-ssh-key](other-ssh-key.jpg)

## 添加到 ssh agent

生成好的 ssh key 我们需要添加到 ssh agent 中，与添加默认的 ssh key 一样

![add-to-ssh-agent](add-to-ssh-agent.jpg)

## 添加config文件

最后我们需要需要在 **.ssh** 目录中创建一个 **config** 文件

```bash
# gitcafe
Host gitcafe.com
  HostName gitcafe.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_rsa.gitcafe
```

现在我默认是使用的 github 的 ssh key，当 host 是 gitcafe.com 时则使用 gitcafe 的 ssh key

![test-ssh](test-ssh.jpg)

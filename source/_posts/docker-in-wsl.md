---
title: Docker In WSL
tags:
  - docker
  - wsl
  - terminal
categories: windows
date: 2019-07-16 17:00:14
---


WSL 虽说可以让我们在 Windows 中运行 Linux，但是它对 Docker 的支持还并不完美

# Docker In WSL

Windows 的 WSL 功能允许在 Windows 中运行 Linux 子系统，但是 WSL 不支持 Docker Daemon，因此虽然 `docker -v` 可以正常执行，但是 `docker run hello-world` 报错 `docker: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?.`

![](./1.png)

## 安装 Docker For Windows

没有办法，那么我们就在宿主机上安装 [Docker For Windows](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)，在设置里面勾选 `Expose daemon on tcp://localhost:2375 without TLS`

![](./2.png)

## 配置 .bashrc

为了每次打开 WSL 终端自动连接宿主机上的 Docker，需要在 `.bashrc` 文件中做相关配置

![](./3.png)

## 今晚吃鸡

好了，现在是到了见证奇迹的时候了，打开 Windows Terminal 输入 `docker run hello-world`

![](./4.png)

## 参考资料

* [https://my.oschina.net/u/3628490/blog/1865780](https://my.oschina.net/u/3628490/blog/1865780)

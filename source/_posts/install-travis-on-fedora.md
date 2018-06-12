---
title: Fedora 系统中安装 travis
tags:
  - fedora
categories: linux
date: 2018-06-13 00:35:09
---


在 fedora 系统中安装 travis-cli 时报错，本文记录下解决方案

<!-- more -->

# 安装 ruby

根据官方文档说明，安装 travis 需要安装 ruby，ruby-devel

```bash
sudo dnf install -y ruby ruby-devel
ruby -v
```

# 安装 travis

根据官方文档安装 travis

```bash
gem install travis -v 1.8.8 --no-rdoc --no-ri
```

这时候会报一个关于 [`Failed to build gem native extension`](https://github.com/travis-ci/travis.rb/issues/558) 的错误。

```bash
Building native extensions. This could take a while...
ERROR:  Error installing travis:
ERROR: Failed to build gem native extension.
......
```

我们通过安装 `libffi-devel` 和 `redhat-rpm-config` 来解决这个问题

```bash
sudo dnf install libffi-devel redhat-rpm-config
```

再次安装 travis，结果如下

```bash
gem install travis -v 1.8.8 --no-rdoc --no-ri
Fetching: travis-1.8.8.gem (100%)
Successfully installed travis-1.8.8
1 gem installed
```

# 参考资料

* [https://github.com/travis-ci/travis.rb/issues/602](https://github.com/travis-ci/travis.rb/issues/602)
* [https://github.com/travis-ci/travis.rb/issues/558](https://github.com/travis-ci/travis.rb/issues/558)

---
title: 如何配置以 nginx 作为服务器的 php 环境
tags:
  - starting
categories: nginx
date: 2017-12-03 19:04:50
---


本文介绍一种最简单的方式搭建以 nginx 作为服务器的 php 环境

<!--more-->

# 下载资源

首先是准备工作，下载相关的资源

## 下载 nginx 服务器

[官网下载](http://nginx.org/)

## 下载 php 包

[官网下载](http://php.net/downloads.php)

# 添加 php 路径到环境变量

![添加 php 路径到环境变量](./1.png)

# 设置 nginx

设置一个新的虚拟服务器

```nginx
server {
  listen  3333;
  server_name  localhost;
  root html;

  location / {
    index  index.php index.html index.htm;
  }

  location ~ \.php$ {
    fastcgi_pass  127.0.0.1:9000;
    fastcgi_index  index.php;
    include  fastcgi.conf;
  }
}
```

# 设置 php

在 php 文件夹根目录中找到 `php.ini-development` 或 `php.ini-production`，任意复制一个并改名为 `php.ini`

# 运行 php-cgi

```bash
php-cgi.exe -b 127.0.0.1:9000
```

![运行 php-cgi](./2.png)

# 测试 php

在 nginx 目录中找到 `html` 文件夹，在里面新建一个 `index.php` 文件并添加以下代码

```php
<?php echo phpinfo();?>
```

然后打开浏览器输入 `http://localhost:3333`

![查看 phpinfo](./3.png)

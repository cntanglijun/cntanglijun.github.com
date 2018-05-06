---
title: 如何在 Fedora27 系统中安装 Jitamin
tags:
  - fedora
categories: linux
date: 2018-03-28 19:09:29
---


Jitamin (读作/ˈdʒɪtəmɪn/) 是一款免费、开源，使用PHP语言开发的项目管理系统。本文记录下如何在 Fedora27 系统中安装 jitamin。

<!--more-->

# Jitamin 的需求

* Web 服务器：Nginx，Apache，或 Lighttpd
* PHP 5.6+（推荐 PHP 7）
* 数据库：MySQL（推荐），PostgreSQL 或 SQLite
* Composer

## 安装 Nginx

```bash
sudo dnf install nginx
```

查看安装版本

```bash
nginx -V

nginx version: nginx/1.12.1
built by gcc 7.1.1 20170802 (Red Hat 7.1.1-7) (GCC)
built with OpenSSL 1.1.0f-fips  25 May 2017 (running with OpenSSL 1.1.0g-fips  2 Nov 2017)
TLS SNI support enabled
configure arguments: --prefix=/usr/share/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --http-client-body-temp-path=/var/lib/nginx/tmp/client_body --http-proxy-temp-path=/var/lib/nginx/tmp/proxy --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi --http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi --http-scgi-temp-path=/var/lib/nginx/tmp/scgi --pid-path=/run/nginx.pid --lock-path=/run/lock/subsys/nginx --user=nginx --group=nginx --with-file-aio --with-ipv6 --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-http_perl_module=dynamic --with-http_auth_request_module --with-mail=dynamic --with-mail_ssl_module --with-pcre --with-pcre-jit --with-stream=dynamic --with-stream_ssl_module --with-google_perftools_module --with-debug --with-cc-opt='-O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -m64 -mtune=generic' --with-ld-opt='-Wl,-z,relro -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -Wl,-E'

```

## 安装 PHP

```bash
sudo dnf install php-cli
```

查看安装版本

```bash
php -v

PHP 7.1.15 (cli) (built: Feb 28 2018 11:19:18) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.1.0, Copyright (c) 1998-2018 Zend Technologies
```

## 安装 MySQL

```bash
sudo dnf install mysql
```

查看安装版本

```bash
mysql -V

mysql  Ver 15.1 Distrib 10.2.13-MariaDB, for Linux (x86_64) using readline 5.1
```

### 安装 mysqli 扩展

```bash
sudo dnf install php-mysqli

php --ini

Configuration File (php.ini) Path: /etc
Loaded Configuration File:         /etc/php.ini
Scan for additional .ini files in: /etc/php.d
Additional .ini files parsed:      /etc/php.d/20-bz2.ini,
/etc/php.d/20-calendar.ini,
/etc/php.d/20-ctype.ini,
/etc/php.d/20-curl.ini,
/etc/php.d/20-dom.ini,
/etc/php.d/20-exif.ini,
/etc/php.d/20-fileinfo.ini,
/etc/php.d/20-ftp.ini,
/etc/php.d/20-gd.ini,
/etc/php.d/20-gettext.ini,
/etc/php.d/20-iconv.ini,
/etc/php.d/20-intl.ini,
/etc/php.d/20-json.ini,
/etc/php.d/20-mbstring.ini,
/etc/php.d/20-mysqlnd.ini,
/etc/php.d/20-pdo.ini,
/etc/php.d/20-phar.ini,
/etc/php.d/20-posix.ini,
/etc/php.d/20-shmop.ini,
/etc/php.d/20-simplexml.ini,
/etc/php.d/20-sockets.ini,
/etc/php.d/20-sqlite3.ini,
/etc/php.d/20-sysvmsg.ini,
/etc/php.d/20-sysvsem.ini,
/etc/php.d/20-sysvshm.ini,
/etc/php.d/20-tokenizer.ini,
/etc/php.d/20-xml.ini,
/etc/php.d/20-xmlwriter.ini,
/etc/php.d/20-xsl.ini,
/etc/php.d/30-mysqli.ini,
/etc/php.d/30-pdo_mysql.ini,
/etc/php.d/30-pdo_sqlite.ini,
/etc/php.d/30-wddx.ini,
/etc/php.d/30-xmlreader.ini,
/etc/php.d/40-zip.ini
```

## 安装 Composer

```bash
sudo dnf install composer
```

查看安装版本

```bash
composer -V

Composer version 1.6.3 2018-01-31 16:28:17
```

# 安装 Jitamin

## 获取源码

```bash
cd /home/tlj
sudo git clone https://github.com/jitamin/jitamin.git
cd jitamin
```

## 设置配置文件

```bash
sudo cp .env.example .env
```

## 安装 PHP 依赖包

```bash
composer install -o --no-dev
```

## 创建数据库并设置相应的配置文件

```bash
MariaDB [(none)]> CREATE DATABASE jitamin;
MariaDB [(none)]> CREATE USER 'jitamin'@'localhost' IDENTIFIED BY 'jitamin';
MariaDB [(none)]> GRANT ALL PRIVILEGES ON jitamin.* TO 'jitamin'@'localhost' IDENTIFIED BY 'jitamin' WITH GRANT OPTION;
```

### 示例 `.env`

```ini
APP_NAME=Jitamin
APP_ENV=production
APP_DEBUG=true
APP_KEY=SomeRandomString
APP_TIMEZONE=Asia/Shanghai
APP_LOCALE=zh-CN
APP_THEME=black
APP_LOG=daily
APP_LOG_LEVEL=error
APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=jitamin
DB_USERNAME=jitamin
DB_PASSWORD=jitamin
```

### 示例 `./config/config.php`

```php
<?php

/*
 * This file is part of Jitamin.
 *
 * Copyright (C) Jitamin Team
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

return [

    // Enable/Disable debug
    'debug' => env('APP_DEBUG', false),

    // Available log drivers: syslog, stderr, stdout or file
    'log_driver' => env('APP_LOG', 'file'),

    // Available cache drivers are "file", "memory" and "memcached"
    'cache_driver' => 'memory',

    // Hide login form, useful if all your users use Google/Github/ReverseProxy authentication
    'hide_login_form' => false,

    // Enable/disable url rewrite
    'enable_url_rewrite' => true,

    // Available db drivers are "mysql", "sqlite" and "postgres"
    'db_driver' => env('DB_CONNECTION', 'mysql'),

    'db_connections' => [
        'sqlite' => [
            'driver'   => 'sqlite',
            'database' => 'jitamin',
        ],

        'mysql' => [
            'driver'    => 'mysql',
            'host'      => env('DB_HOST', 'localhost'),
            'database'  => env('DB_DATABASE', 'jitamin'),
            'username'  => env('DB_USERNAME', 'jitamin'),
            'password'  => env('DB_PASSWORD', 'jitamin'),
            'port'      => env('DB_PORT', '3306'),
            'charset'   => 'utf8',
        ],

        'pgsql' => [
            'driver'   => 'pgsql',
            'host'     => env('DB_HOST', 'localhost'),
            'database' => env('DB_DATABASE', 'jitamin'),
            'username' => env('DB_USERNAME', 'postgres'),
            'password' => env('DB_PASSWORD', ''),
            'port'     => '5432',
            'charset'  => 'utf8',
        ],
    ],
];

```

## 移植并初始化数据库

```bash
vendor/bin/phinx migrate
vendor/bin/phinx seed:run
```

## 确保 `bootstrap/cache` 和 `storage` 有写入权限

```bash
chmod -R 777 bootstrap/cache
chmod -R 777 storage
```

# 运行 Jitamin

## 配置 Nginx

```nginx
# jitamin 服务器
server {
  listen 3000;
  server_name 127.0.0.1;
  root /home/tlj/jitamin/public;

  client_max_body_size 1024m;

  location / {
    try_files $uri $uri/ /index.php$is_args$args;
    index index.php;
  }

  location ~ \.php {
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_index index.php;
    include fastcgi.conf;
  }
}
```

## 开启相关服务

### 启动 nginx

```bash
sudo systemctl start nginx
```

### 启动 mysql

```bash
sudo systemctl start mariadb
```

### 启动 php

```bash
php-cgi -b 127.0.0.1:9000
```

### 浏览器进入系统

![login](./login.png)

# 参考资料

* [https://github.com/jitamin/jitamin/blob/master/README.md](https://github.com/jitamin/jitamin/blob/master/README.md)

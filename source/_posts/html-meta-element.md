---
title: HTML 中的 <meta>
tags: meta
categories: html
date: 2016-03-17 13:53:08
---

整理 html 中 `**&lt;meta&gt;**` 标签的一些用法
<!--more-->

## 设置网页字符编码

```html
<meta charset="UTF-8" />
```

所有字符编码 [http://www.iana.org/assignments/character-sets/character-sets.xhtml](http://www.iana.org/assignments/character-sets/character-sets.xhtml)

## 设置网页关键字

```html
<meta name="keywords" content="HTML,CSS,XML,JavaScript" />
```

## 设置网页描述

```html
<meta name="description" content="ryuu's blog" />
```

## 设置网页作者

```html
<meta name="author" content="ryuu" />
```

## 设置 robots

```html
<meta name="robots" content="contentValue" />
```
contentValue 可以是：

* **index** 允许搜索引擎索引此网页
* **noindex** 阻止搜索引擎索引此网页
* **follow** 允许搜索引擎继续通过此网页的链接索引搜索其它的网页
* **nofollow** 阻止搜索引擎继续通过此网页的链接索引搜索其它的网页
* **noodp** 阻止[Open Directory Project](http://www.dmoz.org/)的使用 (Google, Yahoo, Bing)
* **noarchive** 阻止搜索引擎生成网页快照 (Google, Yahoo)
* **nosnippet** 阻止搜索引擎显示网页的描述 (Google)
* **noimageindex** 阻止引用网页时出现图片索引 (Google)
* **noydir** 阻止 Yahoo Directory description 的使用 (Yahoo)
* **nocache** 与 noarchive 相同 (Bing)
* **all** 等同于 "index,follow"
* **none** 等同于 "noindex, nofollow"

## 设置 googlebot

与 robots 等同，但只允许谷歌爬虫抓取

```html
<meta name="googlebot" content="all" />
```

## 设置 slurp

与 robots 等同，但只允许雅虎的爬虫抓取

## 设置生成器

```html
<meta name="generator" content="IntelliJ IDEA 15.0.4" />
```

## 控制 HTTP Referer 请求头

```html
<meta name="referrer" content="contentValue" />
```

contentValue 可以是：

* **no-referrer** 任何情况下都不发送 referrer 头
* **origin** 发送只包含 host 部分的 referrer。启用这个规则，无论是否发生协议降级，无论是本站链接还是站外链接，都会发送 referrer 头，但是只包含协议 + host 部分（不包含具体的路径及参数等信息）
* **no-referrer-when-downgrade** 仅当发生协议降级（如 HTTPS 页面引入 HTTP 资源，从 HTTPS 页面跳到 HTTP 等）时不发送 referrer 信息。这个规则是现在大部分浏览器默认所采用的
* **origin-when-crossorigin** 仅在发生跨域访问时发送只包含 host 的 referrer，同域下还是完整的。它与origin的区别是多判断了是否 cross-origin。需要注意的是协议、域名和端口都一致，才会被浏览器认为是同域
* **unsafe-URL** 无论是否发生协议降级，无论是本站链接还是站外链接，统统都发送 referrer 信息。正如其名，这是最宽松而最不安全的策略

## 设置创建者

```html
<meta name="creator" content="ryuu" />
```

## 设置发布者

```html
<meta name="publisher" content="ryuu" />
```

## 刷新网页

```html
<meta http-equiv="refresh" content="5" />
```

content 为秒数

## 重定向

```html
<meta http-equiv="refresh" content="0; url=http://f2e-tlj.me" />
```

## 兼容

```html
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
```

## 移动设备

```html
<meta name="viewport" content="width=device-width, initial-scale=1" />
```

### 禁止缩放

```html
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
```

## 开放内容协议

```html
<meta property="[name]" content="contentValue" />
```

[name] 有：

* **og:type** 类型 比如 article video photo 等
* **og:title** 标题
* **og:url** 地址
* **og:image** 图片
* **og:site_name** 网站名
* **og:description** 描述
* **og:updated_time** 更新时间


## 参考资料

* **[http://www.w3schools.com/tags/tag_meta.asp](http://www.w3schools.com/tags/tag_meta.asp)**
* **[https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta)**

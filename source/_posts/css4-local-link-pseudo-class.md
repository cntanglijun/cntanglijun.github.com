---
title: css4 本地链接伪类
tags: css4
categories: css
date: 2017-03-13 15:36:53
---


css4 本地链接伪类

<!--more-->

# 本地链接伪类

> 注意：这个选择器已经从 W3C 草案中移除

这个伪类叫做本地链接伪类，它只选择网站内部的链接。如果传入一个正数给这个选择器，它可以选择链接对分割深度。这些路径是由正斜线（/）分割，但除了协议，用户名，密码，端口，查询字符串以及 URL 的碎片部分。

# 语法

```css
:local-link {
    /* declarations */
}

:local-link(n) {
    /* declarations */
}
```

# 示例

```css
/* 匹配 http://example.com/ link(s) */
:local-link(0) {
    color: red;
}

/* 匹配 http://example.com/year/ link(s) */
:local-link(1) {
    color: red;
}

/* 匹配 http://example.com/year/month/ link(s) */
:local-link(2) {
    color: red;
}
```

第一个例子只选择主域名链接，你能给它设置不同的样式，第二个选择器只匹配第一层深度，第三个例子匹配第二层深度。

# 浏览器支持情况

[http://css4.rocks/selectors-level-4/local-link-pseudo-class.php](http://css4.rocks/selectors-level-4/local-link-pseudo-class.php)

# 参考资料

* [http://css4-selectors.com/selector/css4/local-link-pseudo-class](http://css4-selectors.com/selector/css4/local-link-pseudo-class)
* [http://css4.rocks/selectors-level-4/local-link-pseudo-class.php](http://css4.rocks/selectors-level-4/local-link-pseudo-class.php)

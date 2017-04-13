---
title: css4 匹配任何伪类
tags: css4
categories: css
date: 2017-03-12 23:42:41
---


css4 匹配任何伪类

<!--more-->

# 匹配任何伪类

这个伪类叫做匹配任何伪类，它的参数是一个[选择器列表](https://www.w3.org/TR/selectors/#grouping)(组合选择器无效)。它能使你通过制定匹配所有包含的选择器组来创建选择器集合。但是它不能嵌套自己，比如像这样：`E:matches(:matches(F))`

# 语法

```css
:matches(selector1[, selector2, …]) {}
```

# 示例

```css
section h1, article h1, aside h1 {
    color: red;
}

/* 等同于 */

:matches(section, article, aside) h1 {
    color: red;
}

/* 注意：Mozilla 和 Webkit 需要添加他们自己的前缀：-prefix-any */
:-moz-any(section, article, aside) h1,
:-webkit-any(section, article, aside) h1{
    color: red;
}
```

这个示例用 :matches 选择器选择所有 section，article，aside 的子元素 h1。

# 浏览器支持情况

[http://caniuse.com/#feat=css-matches-pseudo](http://caniuse.com/#feat=css-matches-pseudo)

# 参考资料

* [http://css4-selectors.com/selector/css4/matches-any-pseudo-class](http://css4-selectors.com/selector/css4/matches-any-pseudo-class)
* [http://css4.rocks/selectors-level-4/matches-pseudo-class.php](http://css4.rocks/selectors-level-4/matches-pseudo-class.php)

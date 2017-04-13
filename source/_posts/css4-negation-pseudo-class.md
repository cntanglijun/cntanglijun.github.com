---
title: css4 否定伪类
tags: css4
categories: css
date: 2017-03-03 05:32:19
---

css4 否定伪类

<!-- more -->

# 否定伪类

这个伪类叫做否定伪类，它有一个参数，是一个简单的[选择器列表](https://www.w3.org/TR/selectors/#grouping)(组合选择器无效)。它匹配传入参数以外的元素，但它不能嵌套自己，比如像这个无效示例：`E:not(:not(F))`

# 语法

```css
:not(negation-selector1[, negation-selector2, …]) {}
```

> CSS3 中 `:not` 只支持简单的选择器。

# 示例

```css
a:not([rel="external"], [rel="nofollow"]) {
  color: red;
}
```

这个示例中，所有没有 `rel` 属性值为 `external` 或者 `nofollow` 的链接将被选中。因此，你可以给 external 或者 nofollow (已标记的) 链接添加不同的样式。

# 浏览器支持情况

[http://caniuse.com/#feat=css-not-sel-list](http://caniuse.com/#feat=css-not-sel-list)

# 参考资料

* [http://css4-selectors.com/selector/css4/negation-pseudo-class](http://css4-selectors.com/selector/css4/negation-pseudo-class)
* [http://css4.rocks/selectors-level-4/negation-pseudo-class.php](http://css4.rocks/selectors-level-4/negation-pseudo-class.php)

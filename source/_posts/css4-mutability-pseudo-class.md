---
title: css4 可变性伪类
tags: css4
categories: css
date: 2017-03-15 19:22:29
---


css4 可变性伪类

<!--more-->

# 可变性伪类

可变性伪类表示元素内容为用户更改或不可更改。`:read-only` 表示网站中大多数用户不可编辑的内容。`:read-write` 表示用户可更改的 input 元素或者元素设置了在 HTML5 中引入的 contenteditable 属性，它允许用户编辑元素的内容。

# 语法

```css
:read-only {
  /* declarations */
}

:read-write {
  /* declarations */
}
```

# 示例

```css
:read-only {
  font-family: Verdana, Arial, sans-serif;
}

:read-write {
  font-family: Trebuchet MS, Times New Roman, sans-serif;
  border: 1px dotted gray;
}
```

这个例子中，设置所有用户不可更改的内容的字体为 `Verdana, Arial, sans-serif`，可更改的 input 元素或者可编辑内容的元素设置不同的字体并带有灰色点线边框。

＃ 浏览器支持情况

[http://css4.rocks/selectors-level-4/mutability-pseudo-classes.php](http://css4.rocks/selectors-level-4/mutability-pseudo-classes.php)

# 参考资料

* [http://css4-selectors.com/selector/css4/mutability-pseudo-class](http://css4-selectors.com/selector/css4/mutability-pseudo-class)
* [http://css4.rocks/selectors-level-4/mutability-pseudo-classes.php](http://css4.rocks/selectors-level-4/mutability-pseudo-classes.php)

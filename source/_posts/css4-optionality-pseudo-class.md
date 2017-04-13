---
title: css4 可选性伪类
tags: css4
categories: css
date: 2017-03-15 18:43:00
---


css4 可选性伪类

<!--more-->

# 可选性伪类

可选性伪类选择表单必需元素或表单可选元素。每个 非 `:required` 的 input 元素通过 `:optional` 选择。

# 语法

```css
:required {
  /* declarations */
}

:optional {
  /* declarations */
}
```

# 示例

```css
:required {
  border: 1px solid red;
}

:optional {
  border: 1px solid gray;
}
```

这个例子给可选的 input 元素添加灰色边框，给必需的 input 元素添加红色边框。

# 浏览器支持情况

[http://caniuse.com/#feat=css-optional-pseudo](http://caniuse.com/#feat=css-optional-pseudo)

# 参考资料

* [http://css4-selectors.com/selector/css4/optionality-pseudo-class](http://css4-selectors.com/selector/css4/optionality-pseudo-class)
* [http://css4.rocks/selectors-level-4/optionality-pseudo-classes.php](http://css4.rocks/selectors-level-4/optionality-pseudo-classes.php)

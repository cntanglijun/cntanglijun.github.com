---
title: css4 不确定值伪类
tags: css4
categories: css
date: 2017-03-13 19:15:04
---


css4 不确定值伪类

<!--more-->

# 不确定值伪类

这个伪类叫做不确定值伪类，它代表 radio 元素或者 checkbox 元素的不确定状态。如果 checkbox/radio 既没有选中也没有未选中，类似于非预选的选择。另一个不确定状态是一个未知的进度表完成状态。

# 语法

```css
:indeterminate {
  /* declarations */
}
```

# 示例

```css
:indeterminate {
  opacity: 0.6;
}
```

这个例子减少非预选选择元素的 `opacity` 至 `0.6`。

# 浏览器支持情况

[http://caniuse.com/#feat=css-indeterminate-pseudo](http://caniuse.com/#feat=css-indeterminate-pseudo)

# 参考资料

* [http://css4-selectors.com/selector/css4/indeterminate-value-pseudo-class](http://css4-selectors.com/selector/css4/indeterminate-value-pseudo-class)
* [http://css4.rocks/selectors-level-4/indeterminate-value-pseudo-class.php](http://css4.rocks/selectors-level-4/indeterminate-value-pseudo-class.php)

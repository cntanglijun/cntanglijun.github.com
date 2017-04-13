---
title: css4 范围伪类
tags: css4
categories: css
date: 2017-03-15 18:19:54
---


css4 范围伪类

<!--more-->

# 范围伪类

有效性伪类是范围限制元素的选择器。`:in-range` 选择值在指定范围内的元素，`:out-of-range` 选择值在指定范围外的元素。

# 语法

```css
:in-range {
  /* declarations */
}

:out-of-range {
  /* declarations */
}
```

# 示例

```css
:in-range {
  opacity: 1.0;
}

:out-of-range {
  opacity: 0.6;
}
```

上述示例设置 `:in-range` 元素的 `opacity` 为 `1.0`，设置 `:out-of-range` 元素的为 `0.6`。

＃ 浏览器兼容情况

[http://caniuse.com/#feat=css-in-out-of-range](http://caniuse.com/#feat=css-in-out-of-range)

# 参考资料

* [http://css4-selectors.com/selector/css4/validity-pseudo-class](http://css4-selectors.com/selector/css4/validity-pseudo-class)
* [http://css4.rocks/selectors-level-4/range-pseudo-classes.php](http://css4.rocks/selectors-level-4/range-pseudo-classes.php)

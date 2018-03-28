---
title: css4 时间维度伪类
tags: css4
categories: css
date: 2017-03-13 19:15:21
---


css4 时间维度伪类

<!--more-->

# 时间维度伪类

这个伪类叫做时间维度伪类，它会在一个时间维度元素中选择当前活跃位置，比如在 HTML 语音渲染期间或者在 [HTML5 视频字幕](http://gingertech.net/2008/12/12/attaching-subtitles-to-html5-video/)的显示期间。所有这些选择器类似 :matches()，它们也接受一个可选的简单选择器列表作为参数。这 3 个伪类的不同之处是 :past 选择所有 :current 元素的前一个相邻元素，显然 :future 选择所有 :current 元素的下一个相邻元素。

# 语法

```css
/* 当前 */
:current { /* declarations */ }
:current(s1[, s2, …]) { /* declarations */ }


/* 过去 */
:past { /* declarations */ }
:past(s1[, s2, …]) { /* declarations */ }


/* 未来 */
:future { /* declarations */ }
:future(s1[, s2, …]) { /* declarations */ }
```

# 示例

```css
:current(p, span) {
  background-color: yellow;
}

:past(p, span),
:future(p, span) {
  background-color: gray;
}

```

这些选择器规则表示用黄色背景高亮当前演讲读到的区域，用灰色背景高亮当前元素的上一个以及下一个相邻元素。

# 浏览器支持情况

[http://css4.rocks/selectors-level-4/time-dimensional-pseudo-classes.php](http://css4.rocks/selectors-level-4/time-dimensional-pseudo-classes.php)

# 参考资料

* [http://css4-selectors.com/selector/css4/time-dimensional-pseudo-class](http://css4-selectors.com/selector/css4/time-dimensional-pseudo-class)
* [http://css4.rocks/selectors-level-4/time-dimensional-pseudo-classes.php](http://css4.rocks/selectors-level-4/time-dimensional-pseudo-classes.php)

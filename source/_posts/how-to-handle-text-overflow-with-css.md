---
layout: new
title: CSS 处理文本溢出
tags:
  - css3
categories: css
date: 2020-02-24 18:04:23
---


日常开发中，我们经常会遇到文本超出容器的情况。通常我们会考虑限制文字字数，通过 JS 截取指定字符数，当然也可以通过 CSS 来处理文本溢出。

<!-- more -->

# 单行文本溢出

相关样式

```css
p {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
```

效果演示：

<div style="padding-right: 20px; padding-left: 20px; border: 1px solid #eee;">
  <p style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">那时我懂了，我们尽管是再合适不过的旅伴，但归根结蒂仍不过是描绘各自轨迹的两个孤独的金属块儿。远看如流星一般美丽，而实际上我们不外乎是被幽禁在里面的、哪里也去不了的囚徒。当两颗卫星的轨道偶尔交叉时，我们便这样相会了。也可能两颗心相碰，但不过一瞬之间。下一瞬间就重新陷入绝对的孤独中。总有一天会化为灰烬。</p>
</div>

# 多行文本溢出

相关样式

```css
p {
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  overflow: hidden;
}
```

效果演示：

<div style="width: 100%; padding-right: 20px; padding-left: 20px; border: 1px solid #eee;">
  <p style="display: -webkit-box; -webkit-box-orient: vertical; -webkit-line-clamp: 2; overflow: hidden;">那时我懂了，我们尽管是再合适不过的旅伴，但归根结蒂仍不过是描绘各自轨迹的两个孤独的金属块儿。远看如流星一般美丽，而实际上我们不外乎是被幽禁在里面的、哪里也去不了的囚徒。当两颗卫星的轨道偶尔交叉时，我们便这样相会了。也可能两颗心相碰，但不过一瞬之间。下一瞬间就重新陷入绝对的孤独中。总有一天会化为灰烬。</p>
</div>

# 兼容 IE

相关样式

```css
p {
  position: relative;
  line-height: 1.4em;
  height: 2.8em;
  overflow: hidden;
}

p > span {
  position: absolute:
  right: 0;
  bottom: 0;
  display: block;
  padding-left: 40px;
  background-image: url('./ellipsis.png');
  background-size: cover;
  background-position: center;
}
```

> 注意：行高与高度的比例；span 元素需要一个渐变背景图片过渡。

效果演示：

<div style="width: 100%; padding-right: 20px; padding-left: 20px; border: 1px solid #eee;">
  <p style="position: relative; line-height: 1.4em; height: 2.8em; overflow: hidden;">那时我懂了，我们尽管是再合适不过的旅伴，但归根结蒂仍不过是描绘各自轨迹的两个孤独的金属块儿。远看如流星一般美丽，而实际上我们不外乎是被幽禁在里面的、哪里也去不了的囚徒。当两颗卫星的轨道偶尔交叉时，我们便这样相会了。也可能两颗心相碰，但不过一瞬之间。下一瞬间就重新陷入绝对的孤独中。总有一天会化为灰烬。<span style="position: absolute; right: 0; bottom: 0; display: block; padding-left: 40px; background-image: url('./ellipsis.png'); background-size: cover; background-position: center;">...</span></p>
</div>

# 参考资料

* [https://developer.mozilla.org/en-US/docs/Web/CSS/text-overflow](https://developer.mozilla.org/en-US/docs/Web/CSS/text-overflow)
* [https://developer.mozilla.org/en-US/docs/Web/CSS/-webkit-line-clamp](https://developer.mozilla.org/en-US/docs/Web/CSS/-webkit-line-clamp)
* [https://segmentfault.com/a/1190000008921613](https://segmentfault.com/a/1190000008921613)

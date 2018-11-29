---
title: IOS 微信 webview 中 overflow 值 auto 不能正常工作
tags:
  - wechat
categories: web
date: 2018-11-29 12:40:28
---


在 IOS 系统中，微信 webview 中有时候页面加载完成，但是 `overflow: auto` 属性失效。

<!-- more -->

# 问题描述

## Safari 浏览器的渲染流程

1. 构建 DOM Tree
2. 构建 CSS Rule Tree
3. 根据 DOM 和 CSS Tree 来构建 Render Tree
4. 根据 Render Tree 计算页面的 Layout
5. Render 页面

在第三步和第四部的时候，Safari 浏览器在构建 Render Tree 的时候，会预先找到相应的 `overflow: scroll` 元素，在计算页面 `Layout` 的时候，会计算父元素的高度与子元素的高度，若子元素高于父元素，则在 Render 页面时为其建立一个原生的 ScrollView。
也就是说在计算页面 `Layout` 的时候，子元素高度小于父元素高度则不会建立 ScrollView，也就不会有滚动条。

![problem](./problem.gif)

# 解决方法

根据上述原理，得出解决方案，即在计算页面 `Layout` 时让子元素的高度大于父元素的高度，使其建立 ScrollView。

```html
Layout
  .index
    .inner
      ...

      div(style="height: calc(.5rem)")
```

由于我的 `.inner` 元素高度为 `100%`，内部有许多异步渲染组件，由于数据返回延迟导致计算页面 `Layout` 时子元素高度小于等于父元素高度，无法建立 ScrollView。因此我在最后面加入一个临时元素设置一个高度，使其在组件渲染前将 `.inner` 的高度撑开并建立 ScrollView。

![solve](./solve.gif)

# 参考资料

* [https://segmentfault.com/a/1190000016408566](https://segmentfault.com/a/1190000016408566)

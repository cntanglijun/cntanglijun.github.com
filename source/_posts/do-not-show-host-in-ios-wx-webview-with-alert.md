---
title: IOS 微信 webview 中使用 alert 时不显示当前域名
tags:
  - wechat
categories: web
date: 2018-11-28 17:47:24
---


在 IOS 微信中，系统 alert 会在对话框上自动添加网址，对于用户体验不是很友好。

<!-- more -->

# 问题描述

调用系统 alert 时，系统默认带上当前网址的域名，用户体验不好

![before](./before.gif)

# 解决方案

我们可以重写 `alert` 方法，利用 iframe 中子 `window` 的 `alert` 方法

```js
window.alert = function(name){
  var iframe = document.createElement("iframe")

  iframe.style.display = 'none'
  iframe.setAttribute('src', 'data:text/plain')

  document.body.appendChild(iframe)

  frames[0].window.alert(name)

  iframe.parentNode.removeChild(iframe)
}
```

![after](./after.gif)

# 参考资料

* [https://blog.csdn.net/kirsten_z/article/details/79696220](https://blog.csdn.net/kirsten_z/article/details/79696220)

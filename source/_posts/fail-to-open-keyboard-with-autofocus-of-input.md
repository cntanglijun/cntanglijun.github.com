---
title: 移动端设置了 autofocus 属性的 input 标签无法打开输入法键盘
tags:
  - input
categories: html
date: 2018-08-23 00:51:54
---


众所周知 `input` 标签有一个 `autofocus` 属性，用于对 `input` 标签执行自动获取焦点的行为。但是在移动端，由于移动设备的行为设计，设置了 `autofocus` 属性的 `input` 标签并不能如预期的那样自动获取焦点并弹出输入法键盘，在 iphone 手机中甚至无法自动获取焦点。

<!-- more -->

# 失败的案例

![Android-Wechat-Webview](./android-wechat-webview.jpg)

我们可以看到在 Android 中虽然 `input` 标签自动获取了焦点，但是并没有自动弹出输入框。演示代码如下：

```html
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>移动端设置了 autofocus 属性的 input 标签无法打开输入法键盘</title>
  </head>
  <body>
    <input id="myInput" type="password" placeholder="输入密码" autofocus />
  </body>
</html>

```

# 解决方案

我的解决方案是通过用户行为来触发 `input` 标签的焦点事件，从而正确弹出输入框。

![success-demo-android-wechat-webview](./success-demo-android-wechat-webview.jpg)

当用户点击 `重新输入密码` 时即可弹出输入框了。

![success-demo-android-wechat-webview-2](./success-demo-android-wechat-webview-2.jpg)

演示代码如下：

```html
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title></title>
    <link href="https://res.wx.qq.com/open/libs/weui/1.1.3/weui.min.css" rel="stylesheet">
  </head>
  <body>
    <input id="myInput" type="password" placeholder="输入密码" autofocus />
    <script src="https://res.wx.qq.com/open/libs/weuijs/1.1.4/weui.min.js"></script>
    <script>
      var myInput = document.getElementById('myInput')

      weui.confirm('只有用户行为才能在 input 元素触发 focus() 事件时调起键盘', {
        title: '提示：',
        buttons: [
          {
            label: '我知道了',
            type: 'default'
          },
          {
            label: '重新输入密码',
            onClick: function () {
              myInput.focus()
            }
          }
        ]
      })
    </script>
  </body>
</html>
```

# 参考资料

* [https://stackoverflow.com/questions/23722816/autofocus-text-field-on-mobile-but-no-keyboard](https://stackoverflow.com/questions/23722816/autofocus-text-field-on-mobile-but-no-keyboard)

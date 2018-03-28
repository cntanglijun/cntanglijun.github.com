---
title: 你知道 pjax 吗？
tags: pajax
categories: javascript
date: 2016-03-25 12:06:48
---

也许你知道 ajax，但你不一定知道 pjax。那么本文带你们进入 pjax 的世界一探究竟
<!--more-->

## 什么是 pjax

`pjax` = `pushState` + `ajax`

pjax 使用 ajax 和 pushState 技术实现快速浏览体验并保证真实的网页永久链接，页面标题和历史记录

pjax 首先使用 ajax 从服务器获取 html 并用获取到的 html 替换页面中指定容器中的内容，然后使用 pushState (无需刷新页面，无需重新加载 css 和 js) 更新浏览器当前的 url，给人一种快速加载页面的感觉

请记住！pjax 本质就是 pushState 和 ajax 的组合，高大上并且实用的功能往往就是如此简单 :)

## 在线演示

参考这个地址 [http://pjax.herokuapp.com/](http://pjax.herokuapp.com/)

## 目前支持 pushState 的浏览器

参考这个地址 [http://caniuse.com/#search=pushstate](http://caniuse.com/#search=pushstate)

## pjax 库

* **[https://github.com/defunkt/jquery-pjax](https://github.com/defunkt/jquery-pjax)**

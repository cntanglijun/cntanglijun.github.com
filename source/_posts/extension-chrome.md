---
title: 初识 chrome 扩展
tags: chrome
categories: extension
date: 2016-03-21 11:00:53
---

熟悉下 **chrome** 插件开发
<!--more-->

## 下载demo

以 **set_page_color** 这个扩展为例 **[下载地址](https://developer.chrome.com/extensions/examples/api/browserAction/set_page_color.zip)**

## 文件结构

### manifest.json

**manifest.json** 用于保存一些元数据。例如扩展的名称、描述、版本号等等

![manifest.json](manifest-json.jpg)

### icon.png

扩展图标，显示在工具条的右侧，称之为 **browser action**

![browser-action](browser-action.jpg)

### popup.html

**popup.html** 用于渲染点击 **browser action** 弹出的窗口

![popup-html](popup-html.jpg)

### popup.js

**popup.js** 是 **popup.html** 的主要逻辑代码

![popup-js](popup-js.jpg)

## 调试扩展

### 进入扩展程序

在浏览器地址栏输入：**chrome://extensions/**

![extension-page](extension-page.jpg)

### 勾选开发者模式

![check-developer-mode](check-developer-mode.jpg)

### 加载已解压的扩展

![load-unpacked-extension](load-unpacked-extension.jpg)
![extension-is-loaded](extension-is-loaded.jpg)

### 运行扩展程序

![run-extension](run-extension.jpg)

## 打包扩展

### 点击打包扩展程序按钮

![package-extension](package-extension.jpg)

### 选择扩展程序根目录

![save-package](save-package.jpg)

### 生成打包文件

![package](package.jpg)

## 参考资料

* **[https://developer.chrome.com/extensions/getstarted](https://developer.chrome.com/extensions/getstarted)**
* **[https://developer.chrome.com/extensions/api_index](https://developer.chrome.com/extensions/api_index)**
* **[https://developer.chrome.com/extensions/samples](https://developer.chrome.com/extensions/samples)**
* **[https://developer.chrome.com/extensions/manifest](https://developer.chrome.com/extensions/manifest)**

---
title: 初识 firefox 扩展
categories: extension
tags: firefox
date: 2016-02-03 10:12:49
---

**[firefox](http://www.firefox.com.cn/download/ 'firefox')** 社区有大量的插件可供使用，这些这件是怎么开发的呢，让我们一起来研究研究。
<!--more-->

## 准备工作

### 安装 **nodejs**

**nodejs** [官方下载](https://nodejs.org/en/download/ '官方下载')

![1_1](./1_1.jpg '1_1')

### 安装 **jpm**

**[jpm](https://developer.mozilla.org/en-US/Add-ons/SDK/Tools/jpm 'jpm')** 工具用于开发、调试和打包 **[firefox](http://www.firefox.com.cn/download/ 'firefox')** 插件。它发布在 **[npm](https://www.npmjs.com/package/jpm 'npm')** 上。

```sh
npm i jpm --global
```

![1_2](./1_2.jpg '1_2')
![1_3](./1_3.jpg '1_3')

不想全局安装不加参数 **&minus;&minus;global** 即可

```sh
npm i jpm
```

## 第一个插件

创建一个目录，进入目录，运行 **jpm init** ，根据提示完成初始化

```sh
mkdir myaddon & cd myaddon & jpm init
```

![2_1](./2_1.jpg '2_1')

初始化后目录结构

![2_2](./2_2.jpg '2_2')

使用你最爱的编辑器打开 **index.js** 加入以下代码

```js
var buttons = require('sdk/ui/button/action');
var tabs = require("sdk/tabs");

var button = buttons.ActionButton({
  id: "mozilla-link",
  label: "Visit Mozilla",
  icon: {
    "16": "./icon-16.png",
    "32": "./icon-32.png",
    "64": "./icon-64.png"
  },
  onClick: handleClick
});

function handleClick(state) {
  tabs.open("https://developer.mozilla.org/");
}
```

在我们的插件根目录创建 **data** 目录，并保存3个尺寸的图标到该目录

```sh
mkdir data
```

![](https://mdn.mozillademos.org/files/7635/icon-16.png)
![](https://mdn.mozillademos.org/files/7637/icon-32.png)
![](https://mdn.mozillademos.org/files/7639/icon-64.png)

运行命令 **jpm run**

```sh
jpm run
```

![2_3](./2_3.jpg '2_3')

它会调用 **firefox** 浏览器，并加载我们的插件

![2_4](./2_4.jpg '2_4')

点击右上角的小图标，会打开新的标签页链接到 **https://developer.mozilla.org/**

![2_5](./2_5.jpg '2_5')

开发完成我们需要打包插件，在插件根目录运行命令 **jpm xpi**

```sh
jpm xpi
```

![2_6](./2_6.jpg '2_6')

## 参考资料

* **[https://developer.mozilla.org/en-US/Add-ons/SDK/Tools/jpm](https://developer.mozilla.org/en-US/Add-ons/SDK/Tools/jpm)**
* **[https://developer.mozilla.org/en-US/Add-ons/SDK/Tutorials/Getting&#95;Started&#95;&#40;jpm&#41;](https://developer.mozilla.org/en-US/Add-ons/SDK/Tutorials/Getting&#95;Started&#95;&#40;jpm&#41;)**

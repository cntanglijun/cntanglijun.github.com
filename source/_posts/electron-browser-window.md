---
title: Electron BrowserWindow 类
tags:
  - api
categories: electron
date: 2018-02-14 01:42:34
---


[BrowserWindow](https://electronjs.org/docs/api/browser-window#browserwindow) 创建并控制浏览器窗口。

<!--more-->

# 小试牛刀

创建一个窗口，加载 `https://github.com`

```js
const electron = require('electron')

const BrowserWindow = electron.BrowserWindow
const app = electron.app

let mainWindow

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 800,
    height: 600,

    // 使用接近应用程序背景色提升用户体验
    // https://electronjs.org/docs/api/browser-window#showing-window-gracefully
    backgroundColor: '#2e2c29'
  })

  mainWindow.on('closed', function () {
    mainWindow = null
  })

  mainWindow.loadURL('https://github.com')
}

app.on('ready', createWindow)
```

![loadurl](./loadurl.gif)

# 参考资料

* [https://electronjs.org/docs/api/browser-window](https://electronjs.org/docs/api/browser-window)

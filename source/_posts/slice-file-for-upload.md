---
layout: new
title: JavaScript 文件分块上传
tags:
  - ES5
categories: javascript
date: 2018-05-17 17:03:45
---


本文记录 JavaScript 如何对大文件进行分块上传。

<!-- more -->

# 核心概念

`Blob` 对象提供了 `slice` 方法，用于创建一个包含源 `Blob` 的指定字节范围内的数据的新 `Blob` 对象。`File` 接口基于 `Blob`，继承了该方法。利用此方法，我们就可以对大文件进行分块处理。

# 演示代码

```js

// 设置分块大小
var chunkSize = 1024 * 1024

// 计算总分块
var totalChunk = Math.ceil(filesize / chunkSize)

// 当前分块索引
var chunkIndex = 0

// 分块起始值
var chunkStart = 0

// 分块结束值
var chunkEnd = 0

// 迭代
while (chunkStart < filesize) {
  chunkEnd = chunkStart + chunkSize

  if (chunkEnd > filesize) {
    chunkEnd = filesize
  }

  // 在这里分块处理 :)
  file.slice(chunkStart, chunkEnd)

  chunkStart = chunkEnd
  chunkIndex += 1

  // 最后一块
  if (chunkIndex >= totalChunk) {

    // 操作
  }
}

```

# 参考资料

* [http://tuobaye.com/2017/12/01/谈一谈大文件上传——前台分片和后台合并](http://tuobaye.com/2017/12/01/谈一谈大文件上传——前台分片和后台合并)

---
title: 关于微信缩略图无法获取
tags:
  - wechat
categories: essay
date: 2017-04-08 23:53:54
top: true
---


最近升级了安卓版微信 6.5.6 或者 6.5.7 版，于是很多小伙伴们的微信分享就无法获取 300x300 的首张图片作为缩略图了。

<!--more -->

# 微信公众号与 JSSDK

我们何尝不想使用微信官方的 API 呢？但是作为个人开发者，微信官方就是限制得这么恶心。

![1](./1.png '1')

那好，我去认证。

![2](./2.png '2')

WTF~，&^%$#@!，既然如此那么果断弃坑。

# 开发者们是聪明的

俗话说：上有政策，下有对策。作为开发者，作为玩代码的人，我们必须具备 hackable 精神。聪明的小伙伴发现了这个规律，微信分享缩略图会自动抓取网页上面第一张尺寸大于等于 300x300 的图片作为分享卡片的缩略图。那么 hackable 技巧来了

```html
<body>
  <div style="display: none">
    <img src="your-thumbnail-300x300" />
  </div>
</body>
```

这样我们就不需要微信公众号和 JSSDK，就可以设置我们想要的分享缩略图了。

# 政策变了，那就蛋疼了

那么先看看微信做了哪些调整

[https://mp.weixin.qq.com/s/hAdtKl2i4ilyo9HxT1kXyw](https://mp.weixin.qq.com/s/hAdtKl2i4ilyo9HxT1kXyw)

6.5.4 与 6.5.7 对比

![6.5.4](./6.5.4.png '6.5.4')

![6.5.7](./6.5.7.png '6.5.7')

NO~！我可爱的缩略图没了。

# 解决方案

卸载安卓版微信 6.5.6 或 6.5.7 , 重新安装回 6.5.4 版本。还没有升级的小伙伴就别着急升级啦，先观望观望吧。

下载链接

[http://dldir1.qq.com/weixin/android/weixin654android1000.apk](http://dldir1.qq.com/weixin/android/weixin654android1000.apk)

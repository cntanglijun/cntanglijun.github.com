---
title: 解读 Layabox 示例 03
tags:
  - es5
categories: layabox
date: 2018-06-04 00:19:11
---


本文记录第三个引擎示例展示旋转缩放的应用。

<!-- more -->

# 示例效果

![result](./result.gif)

# 概念简介

## Event 类

Event 是事件类型的集合。[API 详情](https://layaair.ldc.layabox.com/api/?category=Core&class=laya.events.Event)

## 其他

其余概念均在示例一中描述。[查看](/2018/05/25/read-layabox-demo-1/#概念简介)

# 示例代码

```html
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
    <script src="./LayaAirJS_1.7.19.1_beta/js/libs/laya.core.js"></script>
    <script src="./LayaAirJS_1.7.19.1_beta/js/libs/laya.webgl.js"></script>
  </head>
  <body>
    <script>
      (function() {
        var Sprite  = Laya.Sprite;
        var Stage   = Laya.Stage;
        var Event   = Laya.Event;
        var Browser = Laya.Browser;
        var WebGL   = Laya.WebGL;

        var ape;
        var scaleDelta = 0;

        ;(function () {

          // 不支持 WebGL 时自动切换至 Canvas
          Laya.init(Browser.clientWidth, Browser.clientHeight, WebGL)

          Laya.stage.alignV = Stage.ALIGN_MIDDLE
          Laya.stage.alignH = Stage.ALIGN_CENTER

          Laya.stage.scaleMode = 'showall'
          Laya.stage.bgColor = '#232628'

          createApe()
        }());

        function createApe() {
          ape = new Sprite();

          ape.loadImage("../../res/apes/monkey2.png");
          Laya.stage.addChild(ape);
          ape.pivot(55, 72);
          ape.x = Laya.stage.width / 2;
          ape.y = Laya.stage.height / 2;

          Laya.timer.frameLoop(1, this, animate);
        }

        function animate(e) {
          ape.rotation += 2;

          // 心跳缩放
          scaleDelta += 0.02;
          var scaleValue = Math.sin(scaleDelta);
          ape.scale(scaleValue, scaleValue);
        }
      })()
    </script>
  </body>
</html>

```


# 代码地址

[https://github.com/cntanglijun/learn-layabox/blob/master/test3.html](https://github.com/cntanglijun/learn-layabox/blob/master/test3.html)

# 参考资料

* [https://www.layabox.com](https://www.layabox.com)
* [https://layaair.ldc.layabox.com/demo/?category=2d&group=Sprite&name=RoateAndScale](https://layaair.ldc.layabox.com/demo/?category=2d&group=Sprite&name=RoateAndScale)

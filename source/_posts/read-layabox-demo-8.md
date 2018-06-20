---
title: 解读 Layabox 示例 08
tags:
  - es5
categories: layabox
date: 2018-06-21 01:09:19
---


本文解读第八个 layabox 引擎示例（`节点控制`）

<!-- more -->

# 示例效果

![result](./result.gif)

# 概念简介

本示例中的概念均在示例一中描述。[查看](/2018/05/25/read-layabox-demo-1/#概念简介)

# 示例代码

```html
<!DOCTYPE html>
<html lang='en' dir='ltr'>
  <head>
    <meta charset='utf-8'>
    <title>节点控制</title>
    <script src='./LayaAirJS_1.7.19.1_beta/js/libs/laya.core.js'></script>
    <script src='./LayaAirJS_1.7.19.1_beta/js/libs/laya.webgl.js'></script>
  </head>
  <body>
    <script>
      (function() {
        var Sprite = Laya.Sprite
        var Stage = Laya.Stage
        var Browser = Laya.Browser
        var WebGL = Laya.WebGL

        var ape1
        var ape2

        ;(function() {

          // 不支持WebGL时自动切换至Canvas
          Laya.init(Browser.clientWidth, Browser.clientHeight, WebGL)

          Laya.stage.alignV = Stage.ALIGN_MIDDLE
          Laya.stage.alignH = Stage.ALIGN_CENTER

          Laya.stage.scaleMode = 'showall'
          Laya.stage.bgColor = '#232628'

          createApes()
        }());

        function createApes() {

          // 加载两只猩猩
          ape1 = new Sprite()
          ape2 = new Sprite()

          ape1.loadImage('./res/apes/monkey2.png')
          ape2.loadImage('./res/apes/monkey2.png')

          // 设置中心点为 55, 72，即图像大小的 1/2
          ape1.pivot(55, 72)
          ape2.pivot(55, 72)

          // 猩猩 1 放在舞台中间位置
          ape1.pos(Laya.stage.width / 2, Laya.stage.height / 2)

          // 猩猩 2 放在 x 轴 200，y 轴 0 的位置
          ape2.pos(200, 0)

          // 猩猩 1 添加到舞台中
          Laya.stage.addChild(ape1)

          // 猩猩 2 添加为猩猩 1 的子集
          ape1.addChild(ape2)

          // 添加逐帧动画
          Laya.timer.frameLoop(1, this, animate)
        }

        function animate(e) {

          // 由于 ape2 是 ape1 的子集，所以 ape1 旋转时 ape2 跟着一起旋转
          ape1.rotation += 2

          // ape2 旋转不影响 ape1
          ape2.rotation -= 4
        }
      }())
    </script>
  </body>
</html>
```

# 参考资料

* [https://www.layabox.com](https://www.layabox.com)
* [https://layaair.ldc.layabox.com/demo/?category=2d&group=Sprite&name=NodeControl](https://layaair.ldc.layabox.com/demo/?category=2d&group=Sprite&name=NodeControl)

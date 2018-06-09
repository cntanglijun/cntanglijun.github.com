---
title: 解读 Layabox 示例 02
tags:
  - es5
categories: layabox
date: 2018-05-30 12:11:17
---

第二个引擎示例展示容器的应用。

<!-- more -->

# 示例效果

![result](./result.gif)

# 概念简介

本示例中的概念均在示例一中描述。[查看](/2018/05/25/read-layabox-demo-1/#概念简介)

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
      (function () {
        var Sprite = Laya.Sprite
        var Stage = Laya.Stage
        var Event = Laya.Event
        var Browser = Laya.Browser
        var WebGL = Laya.WebGL

        // 该容器用于装载 4 张猩猩图片
        var apesCtn

        ;(function () {

          // 不支持 WebGL 时自动切换至 Canvas
          Laya.init(Browser.clientWidth, Browser.clientHeight, WebGL)

          Laya.stage.alignV = Stage.ALIGN_MIDDLE
          Laya.stage.alignH = Stage.ALIGN_CENTER

          Laya.stage.scaleMode = 'showall'
          Laya.stage.bgColor = '#232628'

          createApes()
        }());

        function createApes() {

          // 每只猩猩距离中心点 150 像素
          var layoutRadius = 150
          var radianUnit = Math.PI / 2

          apesCtn = new Sprite()

          Laya.stage.addChild(apesCtn)

          // 添加 4 张猩猩图片
          for (var i = 0; i < 4; i += 1) {
            var ape = new Sprite()

            ape.loadImage('./res/apes/monkey' + i + '.png')

            // 设置轴心点
            ape.pivot(55, 72)

            // 以圆周排列猩猩
            ape.pos(Math.cos(radianUnit * i) * layoutRadius, Math.sin(radianUnit * i) * layoutRadius)

            apesCtn.addChild(ape)
          }

          // 设置猩猩的位置在舞台中央
          apesCtn.pos(Laya.stage.width / 2, Laya.stage.height / 2)

          // 每 1 帧执行动画 animate
          Laya.timer.frameLoop(1, this, animate)
        }

        function animate(e) {

          // 旋转角度 + 1
          apesCtn.rotation += 1
        }
      }())
    </script>
  </body>
</html>
```

# 参考资料

* [https://www.layabox.com](https://www.layabox.com)
* [https://layaair.ldc.layabox.com/demo/?category=2d&group=Sprite&name=Container](https://layaair.ldc.layabox.com/demo/?category=2d&group=Sprite&name=Container)

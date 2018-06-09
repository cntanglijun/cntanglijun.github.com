---
title: read-layabox-demo-4
tags:
  - es5
categories: layabox
date: 2018-06-09 09:46:50
---


本文记录第四个 layabox 引擎示例（`根据数据绘制路径`）

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
      (function() {
        var Sprite  = Laya.Sprite
        var Stage   = Laya.Stage
        var Browser = Laya.Browser
        var WebGL   = Laya.WebGL

        ;(function() {

          // 不支持WebGL时自动切换至Canvas
          Laya.init(Browser.clientWidth, Browser.clientHeight, WebGL)

          Laya.stage.alignV = Stage.ALIGN_MIDDLE
          Laya.stage.alignH = Stage.ALIGN_CENTER

          Laya.stage.scaleMode = "showall"
          Laya.stage.bgColor = "#232628"

          drawPentagram()
        }());

        function drawPentagram() {

          // 创建图形实例
          var canvas = new Sprite()

          // 把图形添加到舞台中
          Laya.stage.addChild(canvas)

          // 定义路径数据
          var path = []

          // 添加路径坐标集合
          path.push(0, -130)
          path.push(33, -33)
          path.push(137, -30)
          path.push(55, 32)
          path.push(85, 130)
          path.push(0, 73)
          path.push(-85, 130)
          path.push(-55, 32)
          path.push(-137, -30)
          path.push(-33, -33)

          // 从舞台中心点，绘制多边形（五角星）
          // drawPoly 方法详情：https://layaair.ldc.layabox.com/api/?category=Core&class=laya.display.Graphics#drawPoly()
          canvas.graphics.drawPoly(Laya.stage.width / 2, Laya.stage.height / 2, path, '#FF7F50')
        }
      }())
    </script>
  </body>
</html>
```

# 参考资料

* [https://www.layabox.com](https://www.layabox.com)
* [https://layaair.ldc.layabox.com/demo/?category=2d&group=Sprite&name=DrawPath](https://layaair.ldc.layabox.com/demo/?category=2d&group=Sprite&name=DrawPath)

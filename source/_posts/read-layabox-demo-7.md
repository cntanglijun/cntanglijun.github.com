---
title: 解读 Layabox 示例 07
tags:
  - es5
categories: layabox
date: 2018-06-19 14:15:14
---


本文解读第七个 layabox 引擎示例（`缓存为静态图像`）

<!-- more -->

# 示例效果

![result](./result.png)

# 概念简介

## Text 类

Text 类用于创建显示对象以显示文本。[API 详情](https://layaair.ldc.layabox.com/api/?category=Core&class=laya.display.Text)

## Stat 类

Stat 类是一个性能统计面板，可以实时更新相关的性能参数。[API 详情](https://layaair.ldc.layabox.com/api/?category=Core&class=laya.utils.Stat)

## 其他

其余概念均在示例一中描述。[查看](/2018/05/25/read-layabox-demo-1/#概念简介)

# 示例代码

```html
<!DOCTYPE html>
<html lang='en' dir='ltr'>
  <head>
    <meta charset='utf-8'>
    <title>缓存为静态图像</title>
    <script src='./LayaAirJS_1.7.19.1_beta/js/libs/laya.core.js'></script>
    <script src='./LayaAirJS_1.7.19.1_beta/js/libs/laya.webgl.js'></script>
  </head>
  <body>
    <script>
      (function() {
        var Sprite = Laya.Sprite
        var Stage = Laya.Stage
        var Text = Laya.Text
        var Stat = Laya.Stat
        var WebGL = Laya.WebGL

        var sp

        ;(function() {

          // 不支持WebGL时自动切换至Canvas
          Laya.init(800, 600, WebGL)

          Laya.stage.alignV = Stage.ALIGN_MIDDLE
          Laya.stage.alignH = Stage.ALIGN_CENTER

          Laya.stage.scaleMode = 'showall'
          Laya.stage.bgColor = '#232628'

          // 显示性能统计信息
          Stat.show()

          setup()
        }());

        function setup() {
          var textBox = new Sprite()

          // 随机摆放 1000 个文本
          var text

          for (var i = 0; i < 1000; i ++) {
            text = new Text()

            // 设置文本字体大小为 20 px
            text.fontSize = 20

            // 设置文本内容为随机整数
            text.text = (Math.random() * 100).toFixed(0)

            // 设置文本旋转角度为随机角度
            text.rotation = Math.random() * 360

            // 设置文本颜色
            text.color = '#CCCCCC'

            text.x = Math.random() * Laya.stage.width
            text.y = Math.random() * Laya.stage.height

            textBox.addChild(text)
          }

          // 缓存为静态图像
          textBox.cacheAsBitmap = true

          Laya.stage.addChild(textBox)
        }
      }())
    </script>
  </body>
</html>
```

# 参考资料

* [https://www.layabox.com](https://www.layabox.com)
* [https://layaair.ldc.layabox.com/demo/?category=2d&group=Sprite&name=Cache](https://layaair.ldc.layabox.com/demo/?category=2d&group=Sprite&name=Cache)

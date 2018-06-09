---
title: 解读 Layabox 示例 01
tags:
  - es5
categories: layabox
date: 2018-05-25 17:31:47
---


一次偶然的机会发现了 [Layabox](https://www.layabox.com/)，着实令我眼前一亮，想了想决定入这个坑。

<!-- more -->

# 示例效果

第一个示例使用 Sprite 显示图片，实现下面的效果：

![result.png](./result.png)

# 概念简介

## Sprite 类

Sprite 是基本的显示图形的显示列表节点。[API 详情](https://layaair.ldc.layabox.com/api/?category=Core&class=laya.display.Sprite)

## Stage 类

Stage 是舞台类，显示列表的根结点，所有显示对象都在舞台上显示。[API 详情](https://layaair.ldc.layabox.com/api/?category=Core&class=laya.display.Stage)

## Texture 类

Texture 是一个纹理处理类。[API 详情](https://layaair.ldc.layabox.com/api/?category=Core&class=laya.resource.Texture)

## Browser 类

Browser 是浏览器代理类。[API 详情](https://layaair.ldc.layabox.com/api/?category=Core&class=laya.utils.Browser)

## Handler 类

Handler 是事件处理器类。[API 详情](https://layaair.ldc.layabox.com/api/?category=Core&class=laya.utils.Handler)

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
        var Texture = Laya.Texture
        var Browser = Laya.Browser
        var Handler = Laya.Handler
        var WebGL = Laya.WebGL

        ;(function () {

          // 初始化舞台，不支持 WebGl 时自动切换至 Canvas
          Laya.init(Browser.clientWidth, Browser.clientHeight, WebGL)

          // 设置画布垂直对齐方式
          Laya.stage.alignV = Stage.ALIGN_MIDDLE

          // 设置画布水平对齐方式
          Laya.stage.alignH = Stage.ALIGN_CENTER

          // 设置缩放模式
          Laya.stage.scaleMode = 'showall'

          // 设置舞台的背景颜色
          Laya.stage.bgColor = '#232628'

          showApe()
        }());

        function showApe() {

          // 实例化图形列表节点
          var ape = new Sprite()

          // 把图形列表节点添加到舞台中
          Laya.stage.addChild(ape)

          // 方法1：使用 loadImage 加载图片
          ape.loadImage('./res/apes/monkey3.png')

          // 方法2：使用 drawTexture
          var monkey2 = './res/apes/monkey2.png'

          // 加载图片
          Laya.loader.load(monkey2, Handler.create(this, function () {

            // 获取指定地址资源
            var t = Laya.loader.getRes(monkey2)
            var ape = new Sprite()

            // 绘制纹理
            ape.graphics.drawTexture(t, 0, 0)
            Laya.stage.addChild(ape)

            // 设置坐标位置
            ape.pos(200, 0)
          }))
        }
      }())
    </script>
  </body>
</html>
```

# 参考资料

* [https://www.layabox.com/](https://www.layabox.com/)
* [https://layaair.ldc.layabox.com/demo/?category=2d&group=Sprite&name=DisplayImage](https://layaair.ldc.layabox.com/demo/?category=2d&group=Sprite&name=DisplayImage)

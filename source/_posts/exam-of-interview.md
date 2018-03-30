---
title: 前端面试题汇总
date: 2015-09-09 10:28:51
categories: interview
tags: web
---

搜集和整理一些常见的前端面试题

<!--more-->

# HTML

超文本标记语言(HyperText Markup Language)，用于构造网页的结构

## 盒模型

DOM 中的元素具有内容(content)、内边距(padding)、边框(board)、外边距(margin)，就像我们日常生活中用来装物品的盒子，所以我们形象的将这四个组成部分称之为盒模型

## 行元素，块元素，空元素

* 行元素: input a button label span
* 块元素: div ul ol li p
* 空元素: hr br

# CSS

层叠样式表(Cascading Style Sheets)，用于对 HTML 表现形式的描述和显示规则，级设置样式

## 元素在容器内垂直水平居中

利用 `display: table` 和 `display: table-cell`

示例：[http://runjs.cn/code/ozhihu0n](http://runjs.cn/code/ozhihu0n)

利用 `position: absolute` `top: 50%` `right: 50%` `margin-top: -(元素高 / 2)` `margin-left: -(元素宽 / 2)`

示例：[http://runjs.cn/code/9637pzrc](http://runjs.cn/code/9637pzrc)

利用 `display: flex` `align-items: center`

示例：[http://runjs.cn/code/hwv0ilbk](http://runjs.cn/code/hwv0ilbk)

## 例题

**左边定宽，右边自适应**

[http://runjs.cn/code/pfqjbsxl](http://runjs.cn/code/pfqjbsxl)

# JavaScript

一种基于浏览器的动态、弱类型、基于原型的解释性脚本

## 跨域

现代浏览器都有同源策略，为了保证用户信息的安全，防止恶意的网站窃取数据，营造安全和谐的互联网环境。所以同源策略的存在是必须的也是必要的。但是作为开发者，我们有必要了解一些跨域的技巧来满足日常业务的需求。

### JSONP

JSONP(JSON with Padding)，利用 `<script>` 支持跨域的特性，其本质是 JavaScript 而不是 JSON

```html
<script src="http://xxx.com/get/data?callback=jsonp"></script>
<script>
  function jsonp(data) {
    console.log(data)
  }
</script>
```

后端只需稍作处理

```
server.response(get('callback') + '(' + responseData + ')')
```

优点

* 兼容性好

缺点

* 只能 GET 请求，不能 POST 以及其他 HTTP 请求
* 只能跨域 HTTP 数据请求，无法在页面中进行 JavaScript 的跨域通信
* 没有相对应的 HTTP 状态码
* 不够安全，容易被劫持和攻击

### CORS

CORS 是一个 W3C 标准，全称是"跨域资源共享"(Cross Origin Resource Sharing)

其核心为 `Access-Control-Allow-Origin`

CORS 与 JSONP 的使用目的相同，但是比 JSONP 更强大。JSONP 只支持 GET 请求，CORS 支持所有类型的 HTTP 请求。JSONP 的优势在于支持老式浏览器，以及可以向不支持 CORS 的网站请求数据

优点

* 它是 W3C 标准，体制比较完善，安全验证到位
* 学习成本，服务器 API 重构成本较小

缺点

* 老版本的浏览器不支持
* 只能跨域 HTTP 数据请求，无法在页面中进行 JavaScript 的跨域通信

## 闭包

简单的说，闭包是一种具有状态的函数。也可以理解为其相关的局部变量在函数调用结束之后将会继续存在。创建闭包的常见方式，就是在一个函数内部创建另一个函数。

闭包实现计数器：[http://runjs.cn/code/iyqrqqor](http://runjs.cn/code/iyqrqqor)

闭包实现存取器：[http://runjs.cn/code/3xrx6ojg](http://runjs.cn/code/3xrx6ojg)

闭包实现实现私有属性：[http://runjs.cn/code/26uhwfvq](http://runjs.cn/code/26uhwfvq)

## 继承

## 例题

**实现 `var a = (10).add(20).reduce(2).add(10);`**<br />
示例：[http://runjs.cn/code/umje8kcg](http://runjs.cn/code/umje8kcg)

**jQuery 中 &.fn.extend &.extend 的区别** <br />
$.extend 添加的是 jQuery 类方法，$.fn.extend 添加的是 jQuery 实例方法



## 参考资料

* [浏览器同源政策及其规避方法](http://www.ruanyifeng.com/blog/2016/04/same-origin-policy.html)
* [跨域资源共享 CORS 详解](http://www.ruanyifeng.com/blog/2016/04/cors.html)

# 前端性能优化

* HTML、CSS、JS 进行合并、打包、压缩
* 图片压缩、css sprites、svg sprites、小图标进行 base64 处理
* 尽可能减少 HTTP 请求
* 将不需要在 DOM 渲染前加载的脚本放在 </body> 上方
* 开启 GZIP 压缩，开启缓存
* 使用 CDN 资源

# Web 安全

作为 Web 工程师对于 Web 安全方面我觉得有必要有所了解

## SQL 注入

通过把 SQL 命令用表单提交的方式传给后端，达到欺骗服务器执行恶意的 SQL 操作。

### 举例

假设有一个表单页面

```html
<form type="post" action="http://xxx.com/login">
  <input name="username" type="text" value="张三" />
  <input name="password" type="password" value="' or 1=1--" />
</form>
```

点击提交，后台执行 SQL

```sql
select * from Table where username='张三' and password='' or 1=1--'
```

导致任何人都可以登录系统

### 防御

* 校验用户输入的内容的合法性
* 对敏感数据进行加密
* 避免把服务器错误信息暴露给用户
* 对代码进行安全评审

## CSRF 攻击

跨站请求伪造，全称 `Cross Site Request Forgery`，攻击者盗用用户身份，以用户名义发送恶意请求，可能造成用户个人隐私泄露、财产损失

### 举例

通过简单示例理解 CSRF 攻击

假设用户登录某银行网站，在本地生成 cookies， 随后用户进行转账，调用一下 API

```
http://xxx.com/pay/?money=1000
```

此时，网页中弹出一个领红包窗口，用户点了进去，这个页面里包含

```html
<img alt="" src="http://xxx.com/pay/?money=1000" />
```

导致用户损失 1000 元

### 防御

#### 前端

* 避免在 url 中暴露用户隐私信息
* 用户修改，删除等敏感操作使用 post 方式
* 严格设置 cookies 的域或者不使用 cookies

#### 后端

* 通过 referer、token 或验证码检测用户提交
* 提供加密规则给前端进行授权操作

#### 用户

* 不要随便点击来历不明的邮件以及网页中的不可信的广告链接
* 定期更改所拥有账户的密码
* 在登录情况下尽可能不去打开 tab 浏览其它网页

## XSS 攻击

跨站脚本攻击，全称 `Cross Site Scripting`。为了区别于层叠样式表 `CSS(Cascading Style Sheets)`，所以将第一个字母 `C` 写成 `X`，攻击者通过在网页中的输入区域输入要攻击的 HTML 内容，当用户访问该网页时嵌入的 HTML 内容会被执行，从而达到恶意攻击用户的目的

### 举例

通过一些例子更好的理解 XSS 攻击

#### 反射型 XSS

反射型 XSS(Reflected XSS) 即非持久型 XSS，需要欺骗用户去点击链接才能触发 XSS 攻击，服务器中不存储这样的页面和内容，一般容易出现在搜索页面

```
http://www.xxx.com/s?search=<script>alert('XSS')</script>
```

#### 存储型 XSS

存储型 XSS(Stored XSS) 即持久性 XSS，它会在服务器中存储恶意内容，相比反射型 XSS 更危险

```html
<input type="text" name="XSS" value="<script>alert('XSS')</script>"/>
```

#### DOM 型 XSS

DOM 型 XSS 是由于 JavaScript 代码的缺陷所导致的 XSS 攻击，所以作为 Web 前端工程尤其要注意，比较常见从 url 参数中取值并把相关内容添加到 DOM 时发生

```
http://www.xxx.com/index.html#msg=<img src="xss" onerror="alert(1)" />
```

```js
document.body.innerHTML = getHashParam('msg')
```

### 防御

对非信任的输入数据进行必要的内容过滤。攻击者输入 XSS 内容 > 前端脚本过滤 > Web 服务器过滤 > 后端脚本过滤 > 前端脚本过滤

## 参考资料
* [SQL注入全过程](http://www.cnblogs.com/tester-l/p/6045466.html)
* [从开发角度浅谈CSRF攻击及防御](http://www.cnblogs.com/shytong/p/5308667.html)
* [DOM XSS 典型场景分析与修复指南](https://security.tencent.com/index.php/blog/msg/107)
* [如何用前端防御 XSS 及建立 XSS 报警机制](http://www.freebuf.com/articles/web/110583.html)

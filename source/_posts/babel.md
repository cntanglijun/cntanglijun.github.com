---
title: '开始使用下一代的 Javascript! 那就别犹豫，Babel 是最好的选择'
categories: javascript
tags: babel
date: 2016-08-13 23:31:39
---

**[Babel](https://babeljs.io/)** 是什么? Babel 是一个 JavaScript 编译器,使用 Babel 我们就无需考虑兼容问题而放心的使用下一代 Javascript 语法来写代码!
<!--more-->

## Babel 的工作机制

看一个简单的例子

```js
[1,2,3].map(n => n + 1);
```

经过Babel编译

```js
[1,2,3].map(function(n) {
  return n + 1;
});
```

很神奇吧! ES6 就这样转换成了 ES5 (｡◝‿◜｡)

我们也可以到 **[这里](https://babeljs.io/repl/)** 去亲自体验 Babel

## 安装 Babel

安装 Babel 通过 npm 包管理工具就可以很方便的安装了

```bash
npm i --save-dev babel-cli
```

## 配置 Babel

配置 Babel 也很简单，我们只需要在项目根目录创建 **.babelrc** 文件

```js
{
  "plugins": ["transform-react-jsx"],
  "ignore": [
    "foo.js",
    "bar/**/*.js"
  ]
}
```

也可以直接在 **package.json** 里配置

```js
{
  "name": "my-package",
  "version": "1.0.0",
  "babel": {
    // my babel config here
  }
}
```

## 使用 Babel 编译第一个 js 文件

假设你有一个 **script.js** 想编译为 **script-compiled.js**

```bash
babel script.js --out-file script-compiled.js
```

你想监视文件变动并即使编译可以使用 **&minus;&minus;watch** 或 **&minus;w** 参数

```bash
babel script.js --watch --out-file script-compiled.js
```

更多详细用法可以使用参数 **&minus;&minus;help** 查看

```bash
babel --help
```

## 参考资料
* **[https://babeljs.io/](https://babeljs.io/)**
* **[http://es6.ruanyifeng.com/](http://es6.ruanyifeng.com/)**
* **[https://leanpub.com/understandinges6/read/](https://leanpub.com/understandinges6/read/)**

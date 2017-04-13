---
title: ECMAScript2015(6) RegExp
tags: es6
categories: javascript
date: 2015-12-29 23:54:15
---

ES6 对 RegExp 类做了扩展。
<!--more-->

## RegExp 构造函数

es6 中 RegExp 构造函数允许使用第二个参数覆盖传入的正则表达式的 flags

```js
var re1 = /ab/i,
    // throws an error in ES5, okay in ES6
    re2 = new RegExp(re1, "g");

console.log(re1.toString());  // "/ab/i"
console.log(re2.toString());  // "/ab/g"

console.log(re1.test("ab"));  // true
console.log(re2.test("ab"));  // true

console.log(re1.test("AB"));  // true
console.log(re2.test("AB"));  // false
```

## u flag

称作 **unicode** ，处理 **unicode code points** 序列模式

```js
var text = "𠮷";

console.log(text.length);  // 2
console.log(/^.$/.test(text));  // false
console.log(/^.$/u.test(text));  // true
```

## y flag

称作 **sticky** 。**y** 修饰符的作用与 **g** 修饰符类似，也是全局匹配，后一次匹配都从上一次匹配成功的下一个位置开始。不同之处在于，**g** 修饰符只要剩余位置中存在匹配就可，而 **y** 修饰符确保匹配必须从剩余的第一个位置开始

```js
var text = "hello1 hello2 hello3",
    pattern = /hello\d\s?/,
    result = pattern.exec(text),
    globalPattern = /hello\d\s?/g,
    globalResult = globalPattern.exec(text),
    stickyPattern = /hello\d\s?/y,
    stickyResult = stickyPattern.exec(text);

console.log(result[0]);         // "hello1 "
console.log(globalResult[0]);   // "hello1 "
console.log(stickyResult[0]);   // "hello1 "

pattern.lastIndex = 1;
globalPattern.lastIndex = 1;
stickyPattern.lastIndex = 1;

result = pattern.exec(text);
globalResult = globalPattern.exec(text);
stickyResult = stickyPattern.exec(text);

console.log(result[0]);         // "hello1 "
console.log(globalResult[0]);   // "hello2 "
console.log(stickyResult[0]);   // Error! stickyResult is null
```

## flags 属性

返回正则表达式中的 flags

```js
var re = /ab/g;

console.log(re.source);  // "ab"
console.log(re.flags);  // "g"
```

## sticky 属性

正则表达式中 flags 有 **y** 返回 true，否则返回 false

```js
var pattern = /hello\d/y;

console.log(pattern.sticky);  // true
```

## 参考资料

* **[https://leanpub.com/understandinges6/read/#leanpub-auto-strings-and-regular-expressions](https://leanpub.com/understandinges6/read/#leanpub-auto-strings-and-regular-expressions)**
* **[https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp)**
* **[http://es6.ruanyifeng.com/#docs/regex](http://es6.ruanyifeng.com/#docs/regex)**

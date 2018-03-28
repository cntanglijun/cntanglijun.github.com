---
title: ECMAScript2015(6) Number
categories: javascript
tags: es6
date: 2015-12-29 23:51:25
---

ES6 扩展了 Number 类。
<!--more-->

<style>
  .super {
    vertical-align: super;
    font-size: .6em;
  }
</style>

## 二进制和八进制表示法

```js
0b1101111000 === 888; // => true
0o1570 === 888; // => true
Number('0b1101111000') // => 888
Number('0o1570') // => 888
```

0b(0B) 表示二进制数, 0o(0O) 表示八进制数。二进制或八进制转十进制使用 **Number()**

**Number** 类的详细信息请 **[戳这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number)**

## Number 类新增方法

### Number.isFinite()

```js
Number.isFinite(Infinity);  // false
Number.isFinite(NaN); // false
Number.isFinite(-Infinity); // false
Number.isFinite(0); // true
Number.isFinite(2e64); // true
Number.isFinite('0'); // false, 全局函数 isFinite('0') 会返回 true
```

**Number.isFinite()** 用于检测传入的参数是否是有穷数

**Number.isFinite()** 的详细信息 **[戳这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/isFinite)**

### Number.isInteger()

```js
Number.isInteger(0.1);     // false
Number.isInteger(1);       // true
Number.isInteger(Math.PI); // false
Number.isInteger(-100000); // true
Number.isInteger(NaN);     // false
Number.isInteger(0);       // true
Number.isInteger("10");    // false
```

**Number.isInteger()** 方法用于检测参数是否是整数

**Number.isInteger()** 的详细信息 **[戳这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/isInteger)**

### Number.isNaN()

```js
Number.isNaN(NaN);        // true
Number.isNaN(Number.NaN); // true
Number.isNaN(0 / 0)       // true

// 下面这几个如果使用全局的 isNaN() 时，会返回 true。
Number.isNaN("NaN");      // false，字符串 "NaN" 不会被隐式转换成数字 NaN。
Number.isNaN(undefined);  // false
Number.isNaN({});         // false
Number.isNaN("blabla");   // false

// 下面的都返回 false
Number.isNaN(true);
Number.isNaN(null);
Number.isNaN(37);
Number.isNaN("37");
Number.isNaN("37.37");
Number.isNaN("");
Number.isNaN(" ");
```

**Number.isNaN()** 用于检测传入的值是否是 **NaN**

**Number.isNaN()** 与全局 **isNaN()** 的区别是 **Number.isNan()** 不会强制把参数转为数字

**Number.isNaN()** 的详细信息 **[戳这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/isNaN)**

### Number.isSafeInteger()

```js
Number.isSafeInteger(3);                    // true
Number.isSafeInteger(Math.pow(2, 53))       // false
Number.isSafeInteger(Math.pow(2, 53) - 1)   // true
Number.isSafeInteger(NaN);                  // false
Number.isSafeInteger(Infinity);             // false
Number.isSafeInteger("3");                  // false
Number.isSafeInteger(3.1);                  // false
Number.isSafeInteger(3.0);                  // true
```

**Number.isSafeInteger()** 用于检测传入的值是否是 **安全整数** (处于 -(2<span class="super">53</span>-1) 和 2<span class="super">53</span>-1 之间的整数)

**Number.isSafeInteger()** 的详细信息 **[戳这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/isSafeInteger)**

### Number.parseFloat()

**Number.parseFloat()** 方法可以把一个字符串解析成浮点数。该方法与全局的 parseFloat() 函数相同，并且处于 ECMAScript 6 规范中（用于全局变量的模块化）。

**Number.parseFloat()** 的详细信息 **[戳这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/parseFloat)**

### Number.parseInt()

**Number.parseInt()** 方法可以根据给定的进制数把一个字符串解析成整数。

**Number.parseInt()** 的详细信息 **[戳这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/parseInt)**

## 新增属性

### Number.EPSILON

```js
x = 0.2;
y = 0.3;
z = 0.1;
equal = (Math.abs(x - y + z) < Number.EPSILON);
```

**Number.EPSILON** 常量表示一个极小数, 可以用于表示浮点运算允许的误差范围。

**Number.EPSILON** 的详细信息 **[戳这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/EPSILON)** 也可以 **[戳这里](http://es6.ruanyifeng.com/#docs/number#Number-EPSILON)**

### Number.MAX_SAFE_INTEGER

```js
Number.MAX_SAFE_INTEGER // 9007199254740991
Math.pow(2, 53) - 1     // 9007199254740991
```

**Number.MAX_SAFE_INTEGER** 常量表示 JS 中的最大安全整数 (2<span class="sup">53</span> - 1)

**Number.MAX_SAFE_INTEGER** 的详细信息 **[戳这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/MAX_SAFE_INTEGER)** 也可以 **[戳这里](http://es6.ruanyifeng.com/#docs/number#安全整数和Number-isSafeInteger)**

### Number.MIN_SAFE_INTEGER

```js
Number.MIN_SAFE_INTEGER // -9007199254740991
-(Math.pow(2, 53) - 1)  // -9007199254740991
```

**Number.MIN_SAFE_INTEGER** 常量表示 JS 中的最小安全整数 (-(2<span class="sup">53</span> - 1))

**Number.MIN_SAFE_INTEGER** 的详细信息 **[戳这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/MIN_SAFE_INTEGER)** 也可以 **[戳这里](http://es6.ruanyifeng.com/#docs/number#安全整数和Number-isSafeInteger)**

## 参考资料

[es6入门 阮一峰](http://es6.ruanyifeng.com/#docs/number 'es6入门 阮一峰')
[MDN Number](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number 'MDN Number')

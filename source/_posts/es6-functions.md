---
title: ECMAScript2015(6) Functions
tags: es6
categories: javascript
date: 2016-03-15 14:53:09
---

本文记录 **ES6** 对 **Function** 类的增强与改进
<!--more-->

## 函数的默认参数

定义默认参数的形式是给形参赋值

```js
function log(x, y = 'World') {
  console.log(x, y);
}

log('Hello') // Hello World
log('Hello', 'China') // Hello China
log('Hello', '') // Hello
```
默认参数只有在未指定该参数或该参数为 **undefined** 是才被使用

[more info about this section](https://leanpub.com/understandinges6/read/#leanpub-auto-functions-with-default-parameter-values)

## rest 参数

rest 参数是在参数前面加 **...** 前缀，它是表示一个包含函数剩余参数的数组

```js
function pick(object, ...keys) {
  let result = Object.create(null);

  for (let i = 0, len = keys.length; i < len; i++) {
      result[keys[i]] = object[keys[i]];
  }

  return result;
}
```

### rest 参数只能有一个，并且是最后一个参数

```js
// Syntax error: Can't have a named parameter after rest parameters
function pick(object, ...keys, last) {
  let result = Object.create(null);

  for (let i = 0, len = keys.length; i < len; i++) {
      result[keys[i]] = object[keys[i]];
  }

  return result;
}
```

### res t参数不能用于对象字面量 setter

```js
let object = {
  // Syntax error: Can't use rest param in setter
  set name(...value) {
      // do something
  }
};
```

[more info about this section](https://leanpub.com/understandinges6/read/#leanpub-auto-working-with-unnamed-parameters)

## Function 构造函数

### 支持默认参数

```js
var add = new Function("first", "second = first", "return first + second");

console.log(add(1, 1)); // 2
console.log(add(1)); // 2
```

### 支持 rest 参数

```js
var pickFirst = new Function("...args", "return args[0]");

console.log(pickFirst(1, 2)); // 1
```

[more info about this section](https://leanpub.com/understandinges6/read/#leanpub-auto-increased-capabilities-of-the-function-constructor)

## 扩展运算符

扩展运算符也是加前缀 **...** rest 将逗号分割的参数合并为数组，扩展运算符则将数组分解为逗号分割的参数。

```js
let values = [25, 50, 75, 100]

// equivalent to
// console.log(Math.max(25, 50, 75, 100));
console.log(Math.max(...values)); // 100
```

[more info about this section](https://leanpub.com/understandinges6/read/#leanpub-auto-the-spread-operator)

## name 属性

所有 es6 中的函数都有 **name** 属性

```js
function doSomething() {
    // ...
}

var doAnotherThing = function() {
    // ...
};

console.log(doSomething.name); // "doSomething"
console.log(doAnotherThing.name); // "doAnotherThing"
```

### 特殊的 name 属性

对象中 getter 或 setter 函数的属性 name 会加上前缀 **get** 或 **set**

```js
var doSomething = function doSomethingElse() {
    // ...
};

var person = {
    get firstName() {
        return "Nicholas"
    },
    sayName: function() {
        console.log(this.name);
    }
}

console.log(doSomething.name);      // "doSomethingElse"
console.log(person.sayName.name);   // "sayName"
console.log(person.firstName.name); // "get firstName"
```

使用 **bind** 创建函数的 name 属性带有前缀 **bound**，使用 Function 构造函数创建 name 属性为 **anonymous**

```js
var doSomething = function() {
    // ...
};

console.log(doSomething.bind().name);   // "bound doSomething"

console.log((new Function()).name);     // "anonymous"
```

[more info about this section](https://leanpub.com/understandinges6/read/#leanpub-auto-ecmascript-6s-name-property)

## new.target

es6 引入 new.target 元属性，用于判断函数是否使用 new 关键字

```js
function Person(name) {
    if (typeof new.target !== "undefined") {
        this.name = name; // using new
    } else {
        throw new Error("You must use new with Person.")
    }
}

var person = new Person("Nicholas");
var notAPerson = Person.call(person, "Michael"); // error!
```

[more info about this section](https://leanpub.com/understandinges6/read/#leanpub-auto-clarifying-the-dual-purpose-of-functions)

## 块级函数

es6 支持在代码块中声明函数

```js
"use strict";

if (true) {

  console.log(typeof doSomething); // "function"

  function doSomething() {
      // ...
  }

  doSomething();
}

console.log(typeof doSomething); // "undefined"
```

[more info about this section](https://leanpub.com/understandinges6/read/#leanpub-auto-block-level-functions)

## 箭头函数

es6 新增箭头函数

```js
var reflect = value => value;

// effectively equivalent to:

var reflect = function(value) {
    return value;
};
```

### 箭头函数的特性

* **没有 this, super, arguments, and new.target 绑定**
* **不能使用 new**
* **没有 prototype**
* **不能更改 this**
* **没有 arguments 对象**
* **不能重复命名参数**

[more info about this section](https://leanpub.com/understandinges6/read/#leanpub-auto-arrow-functions)

## 尾调用优化

### 什么是尾调用

函数的最后一步调用另一个函数，称作尾调用

```js
function doSomething() {
  return doSomethingElse(); // tail call
}
```

### 尾调用优化

```js
"use strict";

function doSomething() {
  // optimized
  return doSomethingElse();
}
```

以下情况不能尾调用优化

```js
"use strict";

function doSomething() {
  // not optimized - no return
  doSomethingElse();
}
```

```js
"use strict";

function doSomething() {
  // not optimized - must add after returning
  return 1 + doSomethingElse();
}
```

```js
"use strict";

function doSomething() {
    // not optimized - call isn't in tail position
    var result = doSomethingElse();
    return result;
}
```

```js
"use strict";

function doSomething() {
    var num = 1,
        func = () => num;

    // not optimized - function is a closure
    return func();
}
```

[more info about this section](https://leanpub.com/understandinges6/read/#leanpub-auto-tail-call-optimization)

## 参考资料

* [https://leanpub.com/understandinges6/read/#leanpub-auto-functions](https://leanpub.com/understandinges6/read/#leanpub-auto-functions)
* [http://es6.ruanyifeng.com/#docs/function](http://es6.ruanyifeng.com/#docs/function)

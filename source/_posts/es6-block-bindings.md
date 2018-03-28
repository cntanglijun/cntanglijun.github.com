---
title: ECMAScript2015(6) Block Bindings
categories: javascript
tags: es6
date: 2015-12-21 23:17:31
---
众所周知，javascript 是没有块级作用域的概念的。很多刚学习 javascript 的小伙伴们常常为此而陷入困惑。不过好在 ES6 为 javascript 解决了这个问题。ES6 为 javascript 新增 2 种变量声明的方式 **let** 和 **const** 。
<!--more-->

## var 声明和变量声明提升 (Var Declarations and Hoisting)

让我们先来看一看传统 var 声明变量的运行机制，很多小伙伴曾经都被坑过((┬＿┬)我也是)

```js
function getValue(condition) {

  if (condition) {
    var value = 'blue';

    // other code

    return value;
  } else {

    // value exists here with a value of undefined

    return null;
  }

  // value exists here with a value of undefined
}
```

如果你对 javascript 不是很熟悉，你会认为只有当条件为 true 时 value 才被创建。事实上在 getValue 中变量 value 无论如何都会被创建，原因是 javascript 引擎会这样解析你的代码:

```js
function getValue(condition) {

  var value;

  if (condition) {
    value = 'blue';

    // other code

    return value;
  } else {

    return null;
  }
}
```

函数声明被移至作用域的顶部，这就意味着在 getValue 作用域中，value 都是可以访问的。只有当 condition 为 true 时，它才被初始化为 'blue' 。而在 else 中访问 value 则为 undefined 。因为它还未初始化。

## 块级声明 (Block-Level Declarations)

块级声明是指在指定的块级作用域内声明的变量，该变量在作用域外部无法访问。块级作用域存在于:

* 函数体内
* 代码块内(既 '**{**' 和 '**}**' 中)

ES6 中加入了块级作用域，使得 javascript 与其他基于 C 的语言一样，变得更加灵活和规范。

### let 声明 (Let Declarations)

let 声明变量与 var 一样，唯一不同的是 let 声明的变量作用域是块级的。由于 let 不存在变量声明提升，我们一般将其放在代码块的顶端，确保在当前作用域中都可以访问到它。

```js
function getValue(condition) {
  if (condition) {
    let value = 'blue';
    // other code
    return value;
  } else {
    // value doesn't exist here
    return null
  }
  // value doesn't exist here
}
```

这个版本的 getValue 非常接近其他基于 C 的语言。变量 value 使用 let 代替 var。这就表示变量声明不会被提升至函数顶部，变量 value 在 if 块内执行一次，出了 if 就销毁。如果条件为 false，则不会声明和初始化 value 。

### 禁止重复声明 (No Redeclaration)

如果在当前作用域内已经声明了变量 a，我们在用 let 声明变量 a 则会抛出错误。

```js
var a = 30;

// syntax error
let a = 40;
```

### const 声明 (Constant Declarations)

ES6 中另一种声明变量的方式是使用 const 。const 声明的变量是常量，表示它们的值设置一次后不能被更改。因此，const 变量必须在声明的同时初始化，否则抛出异常

```js
// Valid constant
const maxItems = 30;

// Syntax error: missing initialization
const name;
```

### const，let 的共同点与不同点 (Similarities and Differences from Let)

const 与 let 一样是块级声明，不会声明提升，执行跳出块时变量销毁。

```js
if (condition) {
  const maxItems = 5;

  // more code
}

// maxItems isn't accessible here
```

maxItems 声明在 if 块中，if 执行完成，maxItems 则销毁。if 块外部无法访问变量 maxItems。

const 也禁止重复声明

```js
var message = "Hello!";
let age = 25;

// Each of these would throw an error given the previous declarations
const message = "Goodbye!";
const age = 30;
```

如果是单独声明 2 个常量是有效的，由于前面声明过了同名变量，则这两个常量不能如期工作。

我们需要记住 const 与 let 最大的不同点，那就是无论在严格模式 (strict modes) 下和非严格模式 (non-strict modes) 下尝试给之前定义过的 const 变量赋值都将抛出错误。

```js
const maxItems = 5;

maxItems = 6;  // throws error
```

与大多数其他语言一样，常量 maxItems 的不能改变。但是与其他语言的常量不同，ES6 中的常量的值是对象 (object) 时可以修改。

### 声明 const 对象 (Declaring Objects with Const)

const 声明阻止对变量值的修改和绑定引用的修改。也就是说 const 声明为对象，则不会阻止对该对象内容的修改。

```js
const person = {
  name: 'Nicholas'
};

// works
person.name = 'Greg';

person = {
  name: 'Greg'
};
```

这里 person 绑定了一个带有 name 属性的对象。我们可以正常修改 person.name，因为这是 person 对象内部属性的修改，并没有改变 person 绑定的对象。当我们尝试分配另一个对象给 person (尝试改变绑定的引用)，则会抛出错误。我们很容易对此造成误解。请记住：const 阻止绑定的修改，而不是绑定的值的修改。

### 暂时性死区 (The Temporal Dead Zone)

与 **var** 不同，**let** 和 **const** 没有变量提升特点。变量只有在声明之后才能访问。

```js
if (condition) {
  console.log(typeof value); //ReferenceError!
  let value = 'blue';
}
```

这里我们使用 let 声明并初始化变量 value ，但是语句永远不会执行，因为前一行已经抛出错误。这个问题我们称之为暂时性死区 (TDZ)。TDZ 在 ES6 规范中没有明确命名，不过它是常常用于描述非变量提升声明 (**let** 和 **const**) 的行为的术语。

当 javascript 引擎解析到一个代码块并且发现变量声明，它会将声明提升 (**var**) 或者将声明放进 TDZ (**let**和**const**) 。任何尝试访问 TDZ 中的变量都会导致运行时错误。只有当变量声明执行完毕从 TDZ 中移除时，我们才可以安全的使用它。

不过在if块的外面不会抛出错误。

```js
console.log(typeof value); // 'undefined'

if (condition) {
  let value = 'blue';
}
```

**typeof** 操作的变量 **value** 是在非块级作用域中已经声明的。只是没有绑定值，所以 **typeof** 操作返回 '**undefined**' 。

TDZ 存在于块级作用域，也存在于循环中。

## 循环中的块作用域 (Block Binding in Loops)

javascript 中，我们常常会看到这样的循环代码

```js
for (var i = 0; i < 10; i++) {
  process(items[i]);
}

// i is still accessible here
console.log(i); // 10
```

由于 **var** 存在变量声明提升导致循环外部我们仍然可以访问变量 **i** ，这不是我们希望的，我们只希望计数器 **i** 只在循环内部可用。我们稍作修改

```js
for (let i = 0; i < 10; i++) {
  process(items[i]);
}

// i is not accessible here - throws an error
console.log(i);
```

我们使用 **let** 代替 **var** ，这样就形成了块级作用域，计数器 **i** 只有在循环块中可以访问。一旦循环结束变量就被销毁，外部不再可以访问。

### 循环中的函数 (Functions in Loops)

由于 **var** 存在变量声明提升，这会导致在循环中创建的函数无法得到预期结果。

```js
var funcs = [];

for (var i = 0; i < 10; i++) {
  funcs.push(function() {console.log(i);});
}

funcs.forEach(function (func) {
  func(); // outputs the number '10' then times
});
```

我们希望的结果是输出 0-9，但是结果是输出 10 次 10 。这是因为当循环结束，**i** 的值已经为 10。

为了解决这个问题，开发者们使用立即调用函数表达式 (immediately-invoked function expressions)简称(IIFEs)。

```js
var funcs = [];

for (var i = 0; i < 10; i ++) {
  funcs.push((function (value) {
    return function () {
      console.log(value);
    }
  }(i)));
}

funcs.forEach(function (func) {
  func(); // outputs 0, then 1, then2, up to 9
});
```

我们把变量 **i** 传给 IIFE，它会在创建一个新的 **i** 副本 **value** ，所以在其内部 **value** 的值就是循环计数器 0-9，然后运行结果就和我们预期的一样了。很幸运，现在有了块级作用域，就不用这么麻烦了。

### 循环中的 let声明 (Let Declarations in Loops)

我们可以使用 **let** 简化之前的 IIEF

```js
var funcs = [];

for (let i = 0; i < 10; i++) {
  funcs.push(function () {
    console.log(i);
  });
}

funcs.forEach(function(func) {
  func(); // outputs 0, then 1, then 2, up to 9
});
```

for-in 循环和 for-of 循环中同样适用

```js
var funcs = [],
  object = {
    a: true,
    b: true,
    c: true
  };

for (let key in object) {
  funcs.push(function () {
    console.log(key);
  })
}

funcs.forEach(function (func) {
  func(); // outputs 'a', then 'b', then 'c'
});
```

有一点很重要的需要明白，循环中的 **let** 声明是 ES6 规范中特殊定义的行为与 **let** 的非变量提升特点没有必然的关系。事实上，早期实现的 **let** 没有这个行为，它是后期才被添加进来的。

### 循环中的常量声明 (Constant Declarations in Loops)

ES6 规范没有明确不允许在循环中使用 **const** 声明。但是它的行为有点不同。

```js
var funcs = [];

// throws an error after one iteration
for (const i = 0; i < 10; i++) {
  funcs.push(function() {
    console.log(i);
  });
}
```

我们使用 **const** 声明变量 **i** 。第一次迭代运行正常。然而当 **i++** 执行抛出错误，因为试图改变 **i** 的值。因此我们只能在循环初始化时使用 **const** 声明变量，并且不能修改变量的值。

```js
var funcs = [],
  object = {
    a: true,
    b: true,
    c: true
  };

// doesn't cause an error
for (const key in object) {
  funcs.push(function () {
    console.log(ley);
  });
}

funcs.forEach(function (func) {
  func(); // outputs 'a', then 'b', then 'c'
});
```

for-in 循环和 for-of 循环中可以使用 **const** 正常工作，这是因为每次循环初始化都会创建一个新的绑定，而不是修改值的绑定 (for 循环也是一样的道理)。

## 全局块作用域 (Global Block Bindings)

在全局作用域中使用 **let** 或 **const** 是不常见的。如果这么做了，我们需要了解潜在的命名冲突，因为全局对象有预定义的属性。大多数 javascript 环境，全局变量都被分配为全局对象的属性，全局对象的属性是透明访问的非限制标识符(如 name 或 location)。使用块级声明定义变量与全局属性共享一个名称可能会引发错误，因为全局对象属性可能是不可配置的 (nonconfigurable) 。由于块级作用域不允许在同一作用域重定义同一个标识符，所以不可能 shadow 不可配置的全局属性。

```js
let RegExp = 'Hello!'; // ok
let undefined = 'Hello!'; // throws error
```

第一行重定义了全局 **RegExp** 为字符串。尽管这是有问题的，不过没有发生错误。第二行抛出错误，因为 **undefined** 是一个不可配置的全局私有属性。由于它的定义在环境中被锁定，所以 **let** 声明是非法的。

## 块作用域最佳实践 (Emerging Best Practices for Block Bindings)

默认使用 **const** 声明变量，当我们知道变量需要修改时使用 **let** 。因为大多数变量在初始化后不应该改变它们的值，意外改变变量值是导致 bugs 产生的根源。



## 参考资料

* [understandinges6](https://leanpub.com/understandinges6/read/#leanpub-auto-block-bindings 'https://leanpub.com/understandinges6/read/#leanpub-auto-block-bindings')
* [ECMAScript6入门](http://es6.ruanyifeng.com/#docs/let 'ECMAScript6入门')
* [MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/let 'MDN')

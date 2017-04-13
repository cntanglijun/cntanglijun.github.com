---
title: javascript 闭包
date: 2015-08-17 22:50:00
categories: javascript
tags: es5
---

简单的说，闭包是一种具有状态的函数。也可以理解为其相关的局部变量在函数调用结束之后将会继续存在。创建闭包的常见方式，就是在一个函数内部创建另一个函数。

<!--more-->

## 初识闭包

和其他大多数编程语言一样，javascript 也采用词法作用域，也就是说，函数的执行依赖于变量作用域，这个作用域是在函数定义时决定的，而不是函数调用时决定的。为了实现这种词法作用域，javascript 函数对象的内部状态不仅包含函数的代码逻辑，还必须引用当前的作用域链。函数对象可以通过作用域链相互关联起来，函数体内部的变量都可以保存在函数作用域内，这种特性在计算机科学文献中称为“闭包”。

从技术角度讲，所有 javascript 函数都是闭包：它们都是对象它们都关联到作用域链。定义大多数函数时的作用域链在调用函数时依然有效，但这并不影响闭包。当调用函数时闭包所指向的作用域链和定义函数时的作用域链不是同一个作用域链时，事情就变得非常微妙。当一个函数嵌套了另外一个函数，外部函数将嵌套的函数对象作为返回值返回的时候往往会发生这种事情。有很多强大的编程技术都利用到了这类嵌套的函数闭包，以至于这种编程模式在 javascript 中非常常见。当你第一次碰到闭包时可能会觉得非常让人费解，一旦你掌握了闭包之后，就能非常自如地使用它了，了解这一点至关重要。

``` js
//全局变量
var scope = 'global scope';

function checkScope() {
  //局部变量
  var scope = 'local scope';

  function f() {
    return scope;
  }

  return f();
}

checkScope(); // => local scope;
```

checkScope() 函数声明了一个局部变量，并定义了一个函数 f() ，函数 f() 返回这个局部变量的值，最后返回函数 f() 执行的结果。你应当非常清楚为什么调用 checkScope 会返回 "local scope" 。我们稍作修改，你知道这段代码会返回什么吗？

``` js
  var scope = 'global scope';

  function checkScope() {
    //局部变量
    var scope = 'local scope';

    function f() {
      return scope;
    }

    return f;
  }

  checkScope()(); // 返回值是什么？
```

这段代码中，我们将函数内的一对圆括号移动到了 checkScope() 后面。checkScope() 现在返回的是函数内嵌的一个函数对象，而不是返回结果。在定义函数的作用域外面，调用这个嵌套的函数会发生什么事呢？回想一下词法作用域的基本规则：javascript 函数执行到了作用域链，这个作用域链是函数定义的时候创建的。嵌套的函数 f() 定义在这个作用域里，其中的变量 scope 一定是局部变量，不管在何时何地执行函数 f()，这种绑定在执行函数 f() 时依然有效。因此最后一行代码返回 "local scope" 而不是 "global scope"。

## 利用闭包实现计数器

``` js
function counter() {
  var n = 0;

  return {
    count: function () {
      return n++;
    },
    reset: function () {
      n = 0;
    }
  }
}

//创建两个计数器
var counter1 = counter(),
    counter2 = counter();

counter1.count(); // => 0
counter2.count(); // => 0

counter1.reset(); //重置counter1

counter1.count(); // => 0
counter2.count(); // => 1

```

counter() 函数返回了一个计数器对象，这个对象包含两个方法: count() 返回下一个整数，reset() 函数将计数器重置为内部状态。首先要理解，这两个方法都可以访问私有变量 n。再者，每次调用 counter() 都会创建一个新的作用域链和一个新的私有变量。因此，如果调用 counter() 两次就会创建2个计数器对象，而且彼此包含不同的私有变量，调用其中一个计数器对象的 count() 或者 reset() 不会影响到另外一个对象。

## 利用闭包实现存取器

从技术角度看，其实可以将这个闭包合并为属性存取器方法 getter 和 setter。我们把 counter() 函数稍作修改。

``` js
function counter(n) {
  return {
    //属性getter方法返回并给私有计数器n递增1
    get count() {
      return n++;
    },
    //属性setter确保设置的值大于等于n
    set count(m) {
      if (m >= n) {
        n = m;
      } else {
        throw new Error('count can only be set to a larger value');
      }
    }
  }
}

var counter1 = counter(1000);

counter1.count; // => 1000
counter1.count; // => 1001
counter1.count = 2000;
counter1.count; // => 2000
counter1.count = 2000; // => Error
```

需要注意的是，这个版本的 counter() 函数并未声明局部变量，而只是使用参数 n 来保存私有状态，属性存取器方法可以访问 n。这样的话，调用 counter() 的函数就可以指定私有变量的初始值了。

## 利用闭包实现私有属性

在 javascript 面向对象开发中，我们需要一些属性和方法只在内部访问，对外则提供存取器作特权方法。

```js
var Cat = function (newName, newArea) {
  //私有属性
  var name, area;

  //私有方法
  function checkSpecies(newName) {
    return typeof newName === 'string';
  }
  function checkArea(newArea) {
    return typeof newArea === 'string';
  }

  //特权方法
  this.getName = function () {
    return name;
  };
  this.setName = function (newName) {
    if (!checkSpecies(newName)) {
      throw new Error('error');
    }
    name = newName || '';
  };

  this.getArea = function () {
    return area;
  };
  this.setArea = function (newArea) {
    if (!checkArea(newArea)) {
      throw new Error('error');
    }
    area = newArea || '';
  };

  //构造
  this.setName(newName);
  this.setArea(newArea);
}
//公共属性
Cat.prototype.publicProperty = 'public property';
//公共方法
Cat.prototype.publicMethod = function () {
  alert('public method');
};

//测试
var cat1 = new Cat('加菲猫', '上海');

cat1.name; // => undefined;
cat1.area; // => undefined;

cat1.getName(); // => 加菲猫
cat1.getArea(); // => 上海

cat1.setName('土猫');
cat1.setArea('北京');

cat1.getName(); // => 土猫
cat1.getArea(); // => 北京

cat1.publicProperty; // => public property
cat1.publicMethod(); // => public method
```

这里定义了一个 Cat 类，由于属性 name，area 设置为私有属性，从外部是无法访问它们的。只有通过特权方法才能访问它们。而定义在类原型对象上的属性和方法则是公共的，可以被所有的实例在外部访问。

## 闭包的副作用

请看下面这个例子

```js
function createFunctions() {
  var result = [], i;

  for (i = 0; i < 10; i += 1) {
    result[i] = function () {
      return i;
    };
  }

  return result;
}
```

这个函数返回一个函数数组。表面上看，似乎每个函数都应该返回自己的索引值，也就是位置 0 的函数返回 0，位置 1 的函数返回 1，依次类推。实际上，每个函数都返回 10。因为每个函数的作用域中都保存着 createFunctions() 函数的活动对象，所以它们引用的都是同一个变量i。当 createFunctions() 函数返回后，变量i的值都是 10，此时每个函数都引用着保存变量 i 的同一个变量对象，所以在每个函数内部 i 的值都是 10。

如何让 createFunctions() 正常工作呢？

```js
function createFunctions() {
  var result = [], i;

  for (i = 0; i < 10; i += 1) {
    result[i] = function (num) {
      return function () {
        return num;
      };
    }(i);
  }

  return result;
}
```

在重写了 createFunctions() 函数后，每个函数就会返回各自不同的索引值了。这个版本中，我们没有直接把闭包赋值给数组，而是定义了一个匿名函数，并将立即执行该匿名函数的结果赋值给数组。这里的匿名函数有一个参数 num，也就是最终的函数要返回的值。在调用每个匿名函数时，我们传入了变量 i。由于函数参数是按值传递的，所以就会将变量i的当前值复制给参数 num。而在这个匿名函数内部，又创建并返回了一个访问 num 的闭包。这样一来，result 数组中的每个函数都有自己 num 变量的一个副本，因此就可以返回各自不同的数值了。

## 小结

当在函数内部定义了其他函数时，就创建了闭包。闭包有权访问包含函数内部的所有变量，原理如下：

* 在后台执行环境中，闭包的作用域链包含着它自己的作用域、包含函数的作用域和全局作用域。
* 通常，函数的作用域及其所有变量都会在函数执行结束后被销毁。
* 但是，当函数数返回了一个闭包时，这个函数的作用域将会一直在内存中保存到闭包不存在为止。使用闭包可以在 javascript 中模仿块级作用域( javascript 本身没有块级作用域的概念)，要点如下。
  * 创建并立即调用一个函数，这样既可以执行其中的代码，有不会在内存中留下对该函数的引用。
  * 结果就是函数内部的所有变量都会被立即销毁--除非将某些变量赋值给了包含作用域(即外部作用域)中的变量。

闭包还可以用于在对象中创建私有变量，相关概念和要点如下。

* 即使 javascript 中没有正式的私有对象属性的概念，但可以使用闭包来实现共有方法，而通过公有方法可以访问在包含作用域中定义的变量。
* 有权访问私有变量的公有方法叫做特权方法。
* 可以使用构造函数模式、原型模式来实现自定义类型的特权方法，也可以使用模块模式、增强的模块模式来实现单例的特权方法。

闭包是 javascript 中极其有用的特性，利用它可以实现很多功能。不过，因为创建闭包必须维护额外的作用域，所以过度使用它们可能会占用大量内存。

## 参考资料

* 《javascript编程全解》 井上诚一郎 土江拓郎 滨边将太
* 《javascript权威指南》 David Flanagan
* 《javascript高级程序设计》 Nicholas C.Zakas

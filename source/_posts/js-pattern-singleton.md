---
title: 单体模式
categories: javascript
tags: es5
date: 2015-09-25 10:08:57
---

单体 (singleton) 模式是 JavaScript 中最基本但又最有用的模式之一，它可能比其他任何模式都更常用。这种模式提供了一种将代码组织为一个逻辑单元的手段，这个逻辑单元中的代码可以通过单一的变量进行访问。通过确保单体对象只存在一份实例，你就可以确信自己的所有代码使用的都是同样的全局资源。

单体类在 JavaScript 中有许多用途。它们可以用来划分命名空间，以减少网页中全局变量的数目。它们还可以在一种名为分支 (branching) 的技术中用来封装浏览器之间的差异(借助分支技术，你在使用各种常用的工具函数时就不必再操心浏览器嗅探的事)。更重要的是，借助于单体模式，你可以把代码组织得更为一致，从而使其更容易阅读和维护。

这种模式在 JavaScript 中非常重要，也许比在其他任何语言中都更重要。在网页上使用全局变量有很大的风险，而用单体对象创建的命名空间则是清除这些全局变量的最佳手段之一。仅此一个原因你就该掌握这种模式，更别说它还有许多别的用途。

<!--more-->

## 单体的基本结构

最简单的单体实际上就是一个对象字面量，它把一批有一定关联的方法和属性组织在一起

```js
var Singleton = {
  attribute1: true,
  attribute2: 10,
  method1: function () {},
  method2: function () {}
};
```

在这个示例中，所有那些成员现在都可以通过变量 Singleton 来访问。可以使用圆点运算符

```js
Singleton.attribute1 = false;

var total = Singleton.attribute2 + 5;
var result = Singleton.method1();
```

这个单体对象可以被修改。你可以为其添加新成员，这一点与别的对象字面量没什么不同。你也可以用 delete 运算符删除其现有成员。这实际上违背了面向对象设计的一条原则：类可以被扩展，但不应该被修改。JavaScript 中的所有对象都是易变的，这正是它与 C++ 和 Java 等别的面向对象语言的区别之一。你不必为此忧心忡忡(Python、Ruby 和 Smalltalk 都允许在定义了类之后又对其进行修改)，但是你应该清楚在这种语言中无法阻止对象的修改。如果某些变量需要保护，那么你可以将其定义在闭包之中。

你可能还是没有发觉这种单体对象与普通对象字面量有什么不同。按传统的定义，单体是一个只能被实例化一次并且可以通过一个众所周知的访问点访问的类。要是严格地按这个定义来说，前面的例子所示的并不是一个单体，因为它不是一个可实例化的类。我们打算把单体模式定义得更广义一些：单体是一个用来划分命名空间并将一批相关方法和属性组织在一起的对象，如果它可以被实例化，那么它只能被实例化一次。

对象字面量只是用以创建单体的方法之一。另外，并非所有对象字面量都是单体。如果它只是用来模仿关联数组或容纳数据的话，那就显然不是单体。但如果它是用来组织一批相关方法和属性的话，那就可能是单体。其区别主要在于设计者的意图。

## 划分命名空间

单体对象由两个部分组成：包含着方法和属性成员的对象自身，以及用于访问它的变量。这个变量通常是全局性的，以便在网页上任何地方都能直接访问到它所指向的单体对象。这是单体模式的一个要点。虽然按定义单体不必是全局性的，但它应该在各个地方都能被访问。因为单体对象的所有内部成员都被包装在这个对象中，所以它们不是全局性的。由于这些成员只能通过这个单体对象变量进行访问，因此在某种意义上，可以说它们被单体对象圈在了一个命名空间中。

命名空间是可靠的 JavaScript 编程的一个重要工具。在 JavaScript 中什么都可以被改写，程序员一不留神就会擦除一个变量、函数甚至整个类，而自己却毫无察觉。这种错误查找起来非常费时

```js
//声明一个全局函数
function findProduct(id) {}

//随后，另一个程序员添加了
var resetProduct = $('#reset-product-button');
var findProduct = $('#find-product-button'); //findProduct函数被改写
```

有个问题虽然与这个例子没有直接关系，但却也值得提一句。函数中声明变量时使用的 var 关键字很重要，如果不使用它，那么变量将被声明为全局性的，因此更容易干扰到全局命名空间中的其他代码。

现在回头来看前面的例子。为了避免无意中改写变量，最好的解决办法之一是用单体对象将代码组织在命名空间之中。下面是前面的例子用单体模式改良后的结果

```js
//使用命名空间
var MyNamespace = {
  findProduct: function (id) {

  }
};

//随后，另一个程序员添加代码
var resetProduct = $('#reset-product-button');
var findProduct = $('#find-product-button'); //什么都没有被改写
```

现在 findProduct 函数是 MyNamespace 中的一个方法，它不会被全局命名空间中声明的任何新变量改写。要注意，该方法仍然可以从各个地方访问。不同之处在于现在其调用方式不是 findProduct(id)，而是 MyNamespace.findProduct(id)。还有一个好处就是，这可以让其他程序员大体知道这个方法的声明地点及其作用。用命名空间把类似的方法组织到一起，也有助于增强代码的文档性。

命名空间还可以进一步分割。现在网页上的 JavaScript 代码往往不止有一个来源。其中除了你写的代码之外，还会有库代码、广告代码和徽章代码。这些变量都出现在网页的全局命名空间中。为了避免冲突，可以定义一个用来包含自己的所有代码的全局对象：

```js
var giantCorp = {};
```

然后可以分门别类地把自己的代码和数据组织到这个全局对象中的各个对象(单体)中：

```js
GiantCorp.Common = {
  // 公共模块
};

//错误处理
GiantCorp.ErrorCodes = {
  // 错误处理
};

//页面
GiantCorp.PageHandler = {
  // 页面交互
};
```

来源于外部的代码与 GiantCorp 这个变量发生冲突的可能性很小。如果真有冲突，其造成的问题会非常明显，所以很容易被发现。想到自己办事牢靠，没有把全局命名空间搞得一片狼藉，你大可高枕无忧。你只是在全局命名空间中加入了一个变量，这是一个 JavaScript 程序员可望获得的最小地盘。

## 用作特定网页专用代码的包装器的单体

你已经了解了如何把单体作为命名空间使用，现在我们再介绍单体模式的一个特殊用途。在那种拥有许多网页的网站中，有些 JavaScript 代码是所有网页都要用到，它们通常被存放在独立的文件中：而有些代码则是某个网页专用的，不会被用到其他地方。最好把这两种代码分别包装在自己的单体对象中。

用来包装各个网页专用的代码的单体通常看起来都差不多。它需要封装一些数据(也许是作为常量)、为各网页特有的行为定义一些方法以及定义初始化方法。涉及 DOM 中特有元素的大多数代码，比如添加事件监听器的代码，只有在这些元素加载之后才能工作。你可以通过创建一个 init 方法并将其关联到窗口的 load 事件(或类似的其他事件，比如由此派生出来的 DOMContentLoaded 事件或 DOMLoaded 事件)，将所有这些初始化代码组织到一个地方。

下面是用来包装特定网页专用代码的单体的骨架：

```js
//通用页面对象
Namespace.PageName = {
  //页面常量
  CONSTANT_1: true,
  CONSTANT_2: 10,

  //页面方法
  method1: function () {

  },
  method2: function () {

  },

  //初始化方法
  init: function () {

  }
};

//页面加载后调用初始化方法
addLoadEvent(Namespace.PageName.init);
```

我们用一个 Web 开发中很常见的任务为例示范一下它的用法。我们经常想要用 JavaScript 为表单添加功能。出于平稳退化方面的考虑，通常先创建一个不依赖于 JavaScript 的、使用普通提交机制完成任务的纯 HTML 网页。然后再用 JavaScript 控制表单的行为，以提供额外的特性。

```js
// 页面注册单体，页面处理对象
GiantCorp.RegPage = {
  // 常量
  FORM_ID: 'reg-form',
  OUTPUT_ID: 'reg-results',

  // 表单处理方法
  handleSubmit: function (e) {
    // 阻止传统表单提交
    e.preventDefault();

    var data = {};
    var inputs = GiantCorp.RegPage.formEl.getElementByTagName('input');

    // 收集表单中input中的值
    for (var i = 0, len = inputs.length; i < len; i++) {
      data[inputs[i].name] = inputs[i].value;
    }

    // 发送表单数据到服务器
    GiantCorp.RegPage.sendRegistration(data);
  },
  sendRegistration: function (data) {
    // 使用ajax请求并当请求返回后调用displayResult()方法。
    ...
  },
  displayResult: function (response) {
    // 输出返回信息到指定的输出元素。我们假设服务器返回格式化好的HTML。
    GiantCorp.RegPage.outputEl.innerHTML = response;
  },
  //初始化方法
  init: function () {
    // 获取表单和输出元素
    GiantCorp.RegPage.formEl = $(GiantCorp.RegPage.FORM_ID);
    GiantCorp.RegPage.outputEl = $(GiantCorp.RegPage.OUTPUT_ID);

    // 劫持表单提交
    addEvent(GiantCorp.RegPage.formEl, 'submit', GiantCorp.RegPage.handleSubmit);
  }
};

// 页面加载后调用初始化方法
addLoadEvent(GiantCorp.RegPage.init);
```

上述代码中首先假定 GiantCorp 命名空间已经作为一个空的对象字面量被创建好了。如若不然，代码的第一行就会引发一个错误。下面这行代码可以防止这种错误，如果 GiantCorp 还不存在，它就会定义这个对象，其中使用的逻辑“或”运算符可以在未找到一个属性时为其提供一个默认值：

```js
var GiantCorp = window.GiantCorp || {};
```

在前面的例子中，我们把所关注的两个 HTML 元素的 ID 值作为常量保存起来，这是因为在程序执行期间它们不会发生变化。

其中的初始化方法先获取那两个 HTML 元素的引用，然后把它们作为单体的新属性保存起来。这没问题，你可以在运行时添加或删除单体的成员。这个方法还把一个方法关联到表单的 submit 的事件。此后当表单被提交时，其正常行为会被阻止(这是 e.preventDefault() 的作用)取而代之的是收集表单数据并用 Ajax 方式将其发回服务器的操作。

## 拥有私用成员的单体

使用真正的私用方法的一个缺点在于它们比较耗费内存，因为每个实例都具有方法的一份新副本。不过，由于单体对象只会被实例化一次，因此为其定义真正的私用方法时不必顾虑内存方面的问题。尽管如此，创建伪私用成员还是更容易一些，所以我们先谈谈这种做法。

### 使用下划线表示法

在单体对象内创建私用成员最简单、最直截了当的办法是使用下划线表示法。这可以让其他程序员知道相关方法或属性是私用的，只在对象内部使用。在单体对象中使用下划线表示法是一种告诫其他程序员不要直接访问特定成员的简明办法：

```js
//数据解析单体，字符串分割成数组
GiantCorp.DataParser = {
  //私有方法
  _stripWhitespace: function (str) {
    return str.replace(/\s+/, '');
  },
  _stringSplit: function (str, delimiter) {
    return str.split(delimiter);
  },

  //公有方法
  stringToArray: function (str, delimiter, stripWS) {
    if (stripWS) {
      str = this._stripWhitespace(str);
    }
    var outputArray = this._stringSplit(str, delimiter);
    return outputArray;
  }
};
```

这个例子中的单体对象有一个公用方法 stringToArray。该方法的参数包括一个字符串、一个分隔符，以及一个用以指示是否要删除所有空白字符的可选的布尔值。它的工作主要靠 \_stripWhitespace 和 \_stringSplit 这两个私用方法完成。这两个方法不是该单体有记载的接口的一部分，以后更新时不见得还会存在，所以它们不应该被公开。将它们设计为私用方法，重构所有内部代码时就不必担心会殃及别人的程序。比如说，后来你检查了一下这个对象，觉得 `_stringSplit` 没有必要作为一个单独的函数存在。你可以将其彻底删除，而且因为这是用下划线标记的私用方法，可以确信没人会直接调用它(如果真有这样的人，他们活该遭受报应)。

stringToArray 方法中用 this 访问单体中的其他方法。这是访问单体中其他成员的最简单的做法。但这样做也有一点风险，因为 this 并不一定就指向 GiantCorp.DataParser 。例如，如果把某个方法用作事件监听器，那么其中的 this 可能会指向 window 对象，这意味着 \_stripWhitespace 和 \_stringSplit 这两个方法不会被找到。虽然大多数 JavaScript 库都会为事件关联进行作用域校正，但还是使用全名 GiantCorp.DataParser 访问单体内的其他成员更保险一点。

### 使用闭包

在单体对象中创建私用成员的第二种办法需要借助闭包。把变量和函数定义在构造函数体内(不使用 this 关键字)以使其成为私用成员，此外还在构造函数体内定义了所有的特权方法并用 this 关键字使其可被外界访问。每生成一个该类的实例时，所有声明在构造函数内的方法和属性都会再次创建一份。这可能会非常低效。

因为单体只会被实例化一次，所以你不用担心自己在构造函数中声明了多少成员。每个方法和属性都会被创建一次，所以你可以把它们都声明在构造函数内部(因此也就位于同一个闭包中)。先前你所见的单体都是这样的对象字面量：

```js
//对象字面量单体
MyNamespace.Singleton = {};
```

现在我们用一个在定义后立即执行的函数创建单体：

```js
//带有私有成员的单体, step 1
MyNamespace.Singleton = function () {
  return {};
}();
```

上述两个例子中所创建的两个 MyNamespace.Singleton 完全相同。要注意在第二个例子中并没有把一个函数赋给 MyNamespace.Singleton。那个匿名函数返回一个对象，而赋给 MyNamespace.Singleton 变量的正是这个对象。为了立即执行这个匿名函数，只需在其定义的最后那个大括号后面放上一对圆括号即可。

有写程序员喜欢在那个匿名函数定义外再套上一对圆括号，以表示它会在声明之后立即执行。这在所创建的单体较为庞大时尤其有用，因为你只要瞟一眼就能看出该函数只是用来创建一个闭包。额外加上这对圆括号，前面创建单体那个例子就变成下面的样子：

```js
//带有私有成员的单体, step 1
MyNamespace.Singleton = (function () {
  return {};
}());
```

你可以像以前那样把公用成员添加到作为单体返回的那个对象字面量中：

```js
//带有私有成员的单体, step 2
MyNamespace.Singleton = (function () {
  // 公有方法
  return {
    publicAttribute1: true,
    publicAttribute2: 10,

    publicMethod1: function () {},
    publicMethod2: function (args) {}
  };
}());
```

要是这样得到的结果与直接使用一个对象字面量没什么区别，那又何必劳神加上那层函数包裹呢?原因在于这个包装函数创建了一个可以用来添加真正的私用成员的闭包。任何声明在这个匿名函数中(但不是在那个对象字面中)的变量或函数都只能被在同一个闭包中声明的其他函数访问。这个闭包在匿名函数执行结束后依然存在，所以在其中声明的函数和变量总能从匿名函数所返回的对象内部(并且也只能从内部)访问。

下面的代码示范了在那个匿名函数中添加私用成员的做法：

```js
//带有私有成员的单体, step 3
MyNamespace.Singleton = (function () {
  //私有成员
  var privateArrtibute1 = false;
  var privateArrtibute2 = [1, 2, 3];

  function privateMethod1() {
    ...
  }

  function privateMethod2(args) {
    ...
  }

  // 公有成员
  return {
    publicAttribute1: true,
    publicAttribute2: 10,

    publicMethod1: function () {
      ...
    },
    publicMethod2: function () {
      ...
    }
  }
}());
```

这种单体模式又称模块模式 (module pattern)，指的是它可以把一批相关方法和属性组织为模块并起到划分命名空间的作用。


### 两种技术的比较

现在回到 DataParser 这个例子中来，看看如何在其实现中使用真正的私用成员。现在我们不再为每个私用方法名称的开头添加一个下划线，而是把这些方法定义在闭包中：

```js
//数据解析单体，字符串分割成数组
//现在使用真正的私有方法

GiantCorp.DataParser = (function () {
  // 私有属性
  var whitespaceRegex = /\s+/;

  // 私有方法
  function stripWhitespace(str) {
    return str.replace(whitespaceRegex, '');
  }

  function stringSplit(str, delimiter) {
    return str.split(delimiter);
  }

  // 返回的对象字面量中的成员是公有的，但是可以访问以上在闭包中创建的成员
  return {
    //公有方法
    stringToArray: function (str, delimiter, stripWS) {
      if (stripWS) {
        str = stripWhitespace(str);
      }

      var outputArray = stringSplit(str, delimiter);
      return outputArray;
    }
  };

}());

//调用函数并将返回的对象字面量赋值给GiantCorp.DataParser
```

现在这些私用方法和属性可以直接用其名称访问，不必在其前面加上 “this.” 或 “GiantCorp.DataParser”，这些前缀只用于访问单体对象的公用成员。

这种模式与使用下划线表示法的模式相比有几点优势。把私用放到闭包中可以确保其不会在单体对象之外被使用。你可以自由地改变对象的实现细节，这不会殃及别人的代码。还可以用这种办法对数据进行保护和封装(尽管单体很少被这样用，除非那些数据只能被保存在一个地方)。

在使用这种模式时，你可以享受到真正的私用成员带来的所有好处，而不必付出什么代价，这是因为单体类只会被实例化一次，单体模式之所以是 JavaScript 中最流行、应用最广泛的模式之一，原因即在于此。

## 惰性实例化

前面所讲的单体模式的各种实现方式有一个共同点：单体对象都是在脚本加载时被创建出来。对于资源密集型的或配置开销甚大的单体，也许更合理的做法是将其实例化推迟到需要使用它的时候，这种技术被称为惰性加载 (lazy loading)，它最常用于那些必须加载大量数据的单体。而那些被用作命名空间、特定网页专用代码包装器或组织相关实用方法的工具的单体最好还是立即实例化。

这种惰性加载单体的特别之处在于，对它们的访问必须借助于一个静态方法。应该这样调用其方法：Singleton.getInstance().methodName()，而不是这样调用：Singleton.methodName()。getInstance 方法会检查该单体是否已经被实例化。如果还没有，那么它将创建并返回其实例。如果单体已经实例化过，那么它将返回现有实例。下面我们从前面那个拥有真正的私用成员单体的基本框架出发示范一下如何把普通单体转化为惰性加载单体：

```js
// 私有成员单体，step 3

MyNamespace.Singleton = (function () {
  //私有成员
  var privateAttribute1 = false;
  var privateAttribute2 = [1, 2, 3];

  function privateMethod1() {
    ...
  }

  function privateMethod2(args) {
    ...
  }

  //公有成员
  return {
    publicAttribute1: true,
    publicAttribute2: 10,

    publicMethod1: function () {
      ...
    },
    publicMethod2: function (args) {
      ...
    }
  }
}());
```

这段代码还没有进行任何修改。转化工作的第一步是把单体的所有代码移到一个名为 constructor 的方法中：

```js
// 惰性加载单体通用骨架，step 1.

MyNamespace.Singleton = (function () {
  // 所有通用单体代码写在在这
  function constructor() {
    //私有成员
    var privateAttribute1 = false;
    var privateAttribute2 = [1, 2, 3];

    function privateMethod1() {
      ...
    }

    function privateMethod2(args) {
      ...
    }

    //公有成员
    return {
      publicAttribute1: true,
      publicAttribute2: 10,

      publicMethod1: function() {
        ...
      },
      publicMethod2: function (args) {
        ...
      }
    };
  }
}());
```

这个方法不能从闭包外部访问，这是件好事，因为我们想全权控制其调用时机。公用方法 getInstance 就是用来实现这种控制的。为了使其成为公用方法，只需将其放到一个对象字面量中并返回该对象即可：

```js
// 惰性加载单体通用骨架，step 2.
MyNamespace.Singleton = (function () {
  function constructor() {
    // 所有通用单体代码写在这里
  }
  return {
    getInstance: function () {
      // 控制代码写在这里
    }
  }
}());
```

现在开始编写用于控制单体类实例化时机的代码。它需要做两件事。第一，它必须知道该类是否已经被实例化过，那么它需要掌握其实例的情况，以便能返回这个实例。办这两件事需要用到一个私用属性和已有的私用方法 constructor：

```js
// 惰性加载单体通用骨架，step 3.
MyNamespace.Singleton = (function () {
  //私有属性保存单个实例
  var uniqueInstance;

  function constructor() {
    ...
  }

  return {
    getInstance: function () {
      if (!uniqueInstance) {
        uniqueInstance = constructor();
      }
      return uniqueInstance;
    }
  }
}());
```

把一个单体转化为惰性加载单体后，你必须对调用它的代码进行修改。在本例中，像这样的方法调用：

```js
MyNamespace.Singleton.publicMethod1();
```

应该被改为下面的形式：

```js
MyNamespace.Singleton.getInstance().publicMethod1();
```

惰性加载单体的缺点之一在于其复杂性。用于创建这种类型的单体的代码并不直观，而且不易理解(不过良好的文档可以提供帮助)。如果你需要创建一个延迟实例化的单体，那么最好为其编写一条注释解释这样做的原因，以免别人把它简化为普通单体。

顺便提一句，如果觉得命名空间名称太长，可以创建一个别名来简化它。这种别名只不过是一个保存了对特定对象的引用的变量。在本例中，可以把 MyNamespace.Singleton 简化为 MNS ：

```js
var MNS = MyNamespace.Singleton;
```

这样做会创建一个全局变量，所以最好还是把它声明在一个特定网页专用代码包装器单体中。在存在单体嵌套的情况下，会出现一些作用域方面的问题。在这种场合下访问其他成员最好使用完全限定名(比如 GiantCorp.SingletonName )而不是 this 。

## 分支

分支 (branching) 是一种用来把浏览器间的差异封装到在运行期间进行设置的动态方法中的技术。举个例来说，假设我们需要创建一个返回 XHR 对象的方法。这种 XHR 对象在大多数浏览器中是 XMLHTTPRequest 类的实例，而在 IE 早期版本中则是某种 ActiveX 类的实例。这样一个方法通常会进行某种浏览器嗅探或对象探测。如果不用分支技术，那么每次调用这方法时，所有那些浏览器嗅探代码都要再次运行。要是这个方法的调用很频繁，那么这样做会严重缺乏效率。

更有效的做法是只在脚本加载时一次性地确定针对特定浏览器的代码。这样一来，在初始化完成之后，每种浏览器都只会执行针对它的 JavaScript 实现而设计的代码。能够在运行时动态确定函数代码的能力，正是 JavaScript 的高度灵活性和强大表现能力的一种体现。这种类型的优化很容易理解，它能提高调用这些函数的效率。

你可能一时还难以明白分支这个话题与单体模式有什么关系。在前面所讲的三种模式中，单体对象的所有代码都是在运行时确定的。这在用闭包创建私用成员的模式中最容易看出来：

```js
MyNamespace.Singleton = (function () {
  return {};
}())
```

那个匿名函数在运行时得以执行，其返回的对象字面量被赋值给 MyNamespace.Singleton 变量。我们可以创建两个不同的对象字面量，并根据某种条件将其中之一赋给那个变量：

```js
// 单体分支
MyNamespace.Singleton = (function () {
  var objectA = {
    method1: function () {
      ...
    },
    method2: function () {
      ...
    }
  };
  var objectB = {
    method1: function () {
      ...
    },
    method2: function () {
      ...
    }
  };

  return (someCondition) ? objectA : objectB;
}());
```

上述代码中创建了两个对象字面量，它们拥有相同的一套方法。对于使用这个单体的程序员来说，赋给 MyNamespace.Singleton 的究竟是哪个对象无关紧要，因为这两个对象实现了同样的接口，可以执行同样的任务，不同之处仅仅在于对象的方法具体使用的代码。你并不是只能使用两个分支，只要有理由，你也可以创建具有三四个分支的单体。据以在分支中进行选择的条件值在运行时进行确定。这种条件通常是某种能力检测的结果，意在确保运行代码的 JavaScript 环境实现了所需要的特性。如若不然，则将改而使用应变代码 (fallback code)。

分支技术并不总是更高效的选择。在前面的例子中，有两个对象(objectA 和 objectB)被创建出来并保存在内存中，但派上用场的只有一个。在考虑是否使用这种技术的时候，你必须在缩短计算时间(因为判断该使用哪个对象的代码只会执行一次)和占用更多内存这一利一弊之间权衡一下。下一个例子就属于适合采用分支技术的情况，因为其中的分支对象较小而判断使用哪个对象的开销较大。

## 示例：用分支技术创建 XHR 对象

在本例中我们要创建一个单体，它有一个用来生成XHR对象实例的方法。我们首先应该判断需要多少分支。因为所能实例化的对象只有 3 种不同类型，所以我们需要 3 个分支。这些分支分别按其返回的 XHR 对象类型命名：

```js
//简单的XHR单体工厂, step 1
var SimpleXhrFactory = (function () {
  var standard = {
    createXhrObject: function () {
      return new XMLHttpRequest();
    }
  };

  var activeXNew = {
    createXhrObject = {
      return new ActiveXObject('Msxml2.XMLHTTP');
    }
  };

  var activeXOld = {
    createXhrObject: function () {
      return new ActiveXObject('Microsoft.XMLHTTP');
    }
  };
}());
```

这3个分支各含一个对象字面量，它们都有一个名为 createXhrObject 的方法。这个方法所做的只是返回一个可以用来执行异步请求的新对象。

创建分支型单体的第2步是根据条件将 3 个分支中某一分支的对象赋给那个变量。其具体做法是逐一尝试每种 XHR 对象，直到遇到一个当前 JavaScript 环境所支持的对象为止：

```js
//简单的XHR单体工厂, step 1
var SimpleXhrFactory = (function () {
  var standard = {
    createXhrObject: function () {
      return new XMLHttpRequest();
    }
  };

  var activeXNew = {
    createXhrObject = {
      return new ActiveXObject('Msxml2.XMLHTTP');
    }
  };

  var activeXOld = {
    createXhrObject: function () {
      return new ActiveXObject('Microsoft.XMLHTTP');
    }
  };

  var testObject;
  try {
    testObject = standard.createXhrObject();
    return standard;
  } catch(e) {
    try {
      testObject = activeXNew.createXhrObject();
      return activeXNew;
    } catch(e) {
      try {
        testObject = activeXOld.createXhrObject();
        return activeXOld;
      } catch(e) {
        throw new Error('No XHR object found in this environment');
      }
    }
  }
}());
```

这个单体现在就可以用来生成 XHR 对象的实例。使用该API的程序员只要调用 SimpleXhrFactory.createXhrObject() 就能得到适合特定的运行时环境的 XHR 对象。用了分支技术后，所有那些特性嗅探代码都只会执行一次，而不是每生成一个对象就要执行一次。

这是一种非常有效的技术，它适用于任何只有运行时才能确定具体实现的情况。

## 单体模式的适用场合

从为代码提供命名空间和增强其模块性这个角度来说，你应该尽量多使用单体模式。单体是 JavaScript 中最有用的模式之一，几乎适用于所有大大小小的项目。在简单的快餐型项目中，你可以只是把单体用作命名空间，将自己的所有代码组织在一个全局变量名下。在稍大、稍复杂一点的项目中，单体可以用来把相关代码组织在一起以便日后维护，或者用来把数据或代码安置在一个众所周知的单一位置。在大型或复杂的项目中，它可以起到优化作用：那些开销较大却有很少使用的组件可以被包装到惰性加载单体中，而针对特定环境的代码则可以被包装到分支型单体中。

很少见到有哪个项目用不到某种形式的单体模式。JavaScript 的灵活性使单体可以被用于多种不同任务。可以说，这种模式在 JavaScript 中的重要性大大超过它在其他语言中的重要性。这主要是因为它可以用来创建命名空间以减少全局变量的数目。这种作用对于 JavaScript 非常重要，因为这种语言中的全局变量比其他语言中的更有危险性。网页包含的 JavaScript 代码往往有着五花八门的来源，其编写者形形色色，所以全局变量和函数很容易被改写，从而导致你的代码失灵。可以解决这种问题的单体模式无疑是程序员们工具箱中的一大利器。

## 单体模式之利

单体模式的主要好处在于它对代码的组织作用。把相关方法和属性组织在一个不太会被多次实例化的单体中，可以使代码的调试和维护变得更轻松。描述性的命名空间还可以增强代码的自我说明性，有利于新手阅读和理解。把你的方法包裹在单体中，可以防止它们被其他程序员误改，还可以防止全局命名空间被一大堆变量弄得一团糟。单体可以把你的代码与第三方的库代码和广告代码隔离开来，从而在整理上提高网页的稳定性。

单体模式的一些高级变体可以在开发周期的后期用于对脚本进行优化，提升其性能。使用惰性实例化技术，可以直到需要一个对象的时候才创建它，从而减少那些不需要它的用户承受的不必要的内存消耗(还可能包括带宽消耗)。分支技术则可以用来创建高效的方法，不用管浏览器的兼容性如何。通过根据运行时的条件确定赋给单体变量的对象字面量，你可以创建出为特定环境量身定制的方法，这种方法不会在每次调用时都一再浪费时间去检查运行环境。

## 单体模式之弊

由于单体模式提供的是一种单点访问，所有它有可能导致模块间的强耦合。这是这种模式受到的主要批评，这个批评也很中肯。有时创建一个可实例化的类更为可取，哪怕它只会被实例化一次。因为这种模式可能会导致类间的强耦合，所以它也不利于单元测试。你无法单独测试一个调用了来自单体的方法的类，而只能把它与那个单体作为一个单元一起测试。单体最好还是留给定义命名空间和实现分支型方法这些用途。在这些情况下，耦合不是什么问题。

有时某种更高级的模式会更符合任务的需要。与惰性加载单体相比，虚拟代理能给予你对类实例化方式更多的控制权。你也可以用一个真正的对象工厂来取代分支型单体(虽说这个工厂可能也是一个单体)。

## 小结

单体模式是 JavaScript 中最基本的模式之一。它不仅可以单独使用，还能以这样或那样的形式与大多数模式配合使用。例如，对象工厂就可以被设计为单体，组合对象的所有子对象也可以被封装进一个单体命名空间中。把你的代码包装在一个单体中，就不必担心别人在使用他们时会改写到他们自己的全局变量，这是向创建供大众使用的API这个方向迈出的一大步。这也是成为一个值得信赖的高级 JavaScript 程序员所要经历的第一步。

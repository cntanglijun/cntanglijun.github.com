---
title: 初学Javascript
date: 2015-08-18 18:27:54
categories: javascript
tags: es5
---

你否是了解 javascript 呢？那你是否对这些知识了如指掌呢？

<!--more-->

## 简化代码

过去，当我们需要创建一个对象时，我们会这样写

```js
var car = new Object();
car.colour = 'red';
car.wheels = 4;
car.hubcaps = 'spinning';
car.age = 4;
```

现在也可以写成

```js
var car = {
  colour: 'red',
  wheels: 4,
  hubcaps: 'spinning',
  age: 4
}
```

这样写更加简洁，并且不用重复写对象名。现在，car 运行良好，你也许会遇到 invalidUserInSession ，这个问题主要是出现在 IE 中。不过只要我们在第二个大括号前不写逗号，就可以避免，否则你将会遇到麻烦。

另一个使用缩略标记的地方是定义数组。老的定义方法是这样的：

```js
var moviesThatNeedBetterWriters = new Array(
  'Transformers', 'Transformers2', 'Avatar', 'Indiana Jones 4'
);
```

更简洁的版本是这样的

```js
var moviesThatNeedBetterWriters = [
  'Transformers', 'Transformers2', 'Avatar', 'Indiana Jones 4'
]
```

对于数组，还有关联数组这样一个特别的东西。 你会发现很多代码是这样定义对象的：

```js
var car = new Array();
car['colour'] = 'red';
car['wheels'] = 4;
car['hubcaps'] = 'spinning';
car['age'] = 4;
```

这太疯狂了，不要觉得困惑，“关联数组”只是对象的一个别名而已。

另一种简化代码的方法是使用三元运算符

```js
var direction;

if (x < 200) {
  direction = 1;
} else {
  direction = -1;
}
```

使用三元运算符

```js
var direction = x < 200 ? 1 : -1;
```

条件为 ture 执行 '**?**' 后面的内容，否则执行 '**:**' 后面的内容。

## JSON 数据格式

JSON 是 Javascript Object Notation 的缩写，是 Douglas Crockford 发明的一种轻量级数据交换格式。使用 JSON ，我们可以存储各种复杂的数据并且不需要进行额外的转换。

例如，想要存储一个乐队的信息

```js
var band = {
  "name": "The Red Hot Chili Peppers",
  "members": [
    {
      "name": "Anthony kiedis",
      "role": "lead vocals"
    },
    {
      "name": "Michael Flea Balzary",
      "role": "bass guitar, trumpet, backing vocals"
    },
    {
      "name": "Chad Smith",
      "role": "drums, percussion"
    },
    {
      "name": "John Frusciante",
      "role": "Lead Guitar"
    }
  ],
  "year": "2009"
}
```

可以在 javascript 中直接使用 JSON 。因此利用 JSON 原生支持 javascript ，我们可以解决跨域问题。这种技术叫做 JSON-P

```html
<div id="delicious"></div>
<script>
  function delicious(o) {
    var out = '<ul>';

    for (var i = 0; i < o.length; i += 1) {
      out += '<li><a href="' + o[i].u + '">' + o[i].d + '</a></li>';
    }

    out += '</ul>';

    document.getElementById('delicious').innerHTML = out;
  }
</script>
<script src="http://feeds.delicious.com/v2/json/codepo8/javascript?count=15&callback=delicious"></script>
```

这里请求了 Delicious Web 服务器上的数据，然后将其显示为无序列表。

## 尽量使用原生函数

例如：在一个数组中查找最大值时，我们可能需要遍历整个数组。

```js
var numbers = [3, 342, 23, 22, 124];
var max = 0, i, j;

for (i = 0, j = numbers.length; i < j; i += 1) {
  if (numbers[i] > max) {
    max = numbers[i];
  }
}

alert(max); // => 342
```

可以不用循环，使用数组的 sort 来完成同样是任务。

```js
var numbers = [3, 342, 23, 22, 124];

numbers.sort(function (a, b) {
  return b - a;
});

alert(numbers[0]); // => 342
```

我们也可以使用 Math.max()

```js
var numbers = [3, 342, 23, 22, 124];

var max = Math.max.apply(null, numbers);

alert(max); // => 342
```

Math.max() 甚至可以用来检测浏览器支持哪个属性

```js
var scrollTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
```

如果你想给元素添加 class，你可能会这样写

```js
function addClass(element, class) {
  var currentClass = element.className;

  element.className = (currentClass === '') ? class : currentClass + ' ' + class;
}
```

也可以使用 split() 和 join() 来实现

```js
function addClass(element, class) {
  var currentClasses = element.className.split(' ');

  currentClasses.push(class);

  element.className = currentClasses.join('');
}
```

这样做可以保证类与空格自动分离并且新加的类是显示在最后面的。

## 事件委托

事件是 JavaScript 非常重要的一部分。我们想给一个列表中的链接绑定点击事件，一般的做法是写一个循环，给每个链接对象绑定事件，HTML 代码如下：

```html
<h2>Great Web resources<h2>
<ul id="resources">
  <li><a href="http://opera.com/wsc">Opera Web Standards Curriculuma</a></li>
  <li><a href="http://sitepoint.com">Sitepointa</a></li>
  <li><a href="http://alistapart.com">A List Aparta</a></li>
  <li><a href="http://yuiblog.com">YUI Bloga</a></li>
  <li><a href="http://blameitonthevoices.com">Blame it on the voicesa</a></li>
  <li><a href="http://oddlyspecific.com">Oddly specifica</a></li>
<ul>
```

脚本如下：

```js
(function () {
  var resources = document.getElementById('resources');
  var links = resources.getElementByTagName('a');
  var len = links.length;

  for (var i = 0; i < len; i += 1) {
    links[i].addEventListener('click', handler, false);
  }

  function handler(e) {
    var x = e.target;

    alert(x);

    e.preventDefault();
  }
}());
```

更合理的写法是只给列表的父对象绑定事件，这样可行的原理在于事件是支持冒泡的，代码如下：

```js
(function () {
  var resources = document.getElementById('resources');

  resources.addEventListener('click', handler, false);

  function handler(e) {
    var x = e.target;

    if (x.nodeName.toLocaleLowerCase() === 'a') {
      alert('Event delegation: ' + x);

      e.preventDefault();
    }
  }
}());
```

## 匿名函数

Javascript 最令人烦恼的事情是变量的范围没有定义。任何在函数外定义的变量、函数、数组和对象都是全局的，这意味着相同页中的其他脚本都可以进行调用，因而经常出现参数被覆盖的现象。解决方法就是将变量封装在一个匿名函数中，在定义完函数后立即调用。

```js
var name = 'Chris';
var age = '34';
var status = 'single';

function createMember() {}

function getMemberDetails() {}
```

该页中其他的脚本语句如果含有名为 status 的变量的话就会出现问题。如果将它们封装在名为 myApplication 的匿名函数中，就可以解决这个问题了。

```js
var myApplication = function () {
  var name = 'Chris';
  var age = '34';
  var status = 'single';

  function createMember() {}

  function getMemberDetails() {}
}();
```

但是这样定义使得参数在函数外部不起作用，如果这正是所需要的，没有问题。另外可以省略定义的名字。

```js
(function () {
  var name = 'Chris';
  var age = '34';
  var status = 'single';

  function createMember() {}

  function getMemberDetails() {}
}());
```

但如果需要部分变量或函数可被外部调用，则需要这样改写程序：为了可以调用 createMember() 和 getMemberDetails() 函数，将它们作为 myApplication 的属性返回。

```js
var myApplication = function () {
  var name = 'Chris';
  var age = '34';
  var status = 'single';

  return {
    createMember: function () {},
    getMemberDetails: function() {}
  }
}();
```

这样的用法被称为模块模式或单例模式。Douglas Crockford 多次提到过这个概念，Yahoo YUI 中经常使用它。为了使函数和变量可以被外部调用，需要改变定义的语法，这很令人烦恼。而且，如果要从一个方法中调用另一个方法，还必须在调用时加上 myApplication 前缀。因此，下面这种模式更好。

```js
var myApplication = function () {
  var name = 'Chris';
  var age = '34';
  var status = 'single';

  function createMember() {}

  function getMemberDetails() {}

  return {
    create: createMember,
    get: getMemberDetails
  }
}();
```

这种模式我们称作“揭示模块模式”。

## 配置

在 Javascript 程序中添加配置文件的几个要点

* 在整个脚本文件中添加一个对象作为配置文件。
* 在配置文件中加入使用该脚本程序可能需要改变的所有信息：
  * CSS 的 ID 和类的名称
  * 生成按钮的字符串
  * 数据：比如要展示的图片张数，地图的尺寸等
  * 地点、区域和语言设置
* 将其作为全局属性返回该对象以便人们可以将其重载。大多数时候这一步放在编程的最后阶段。

其实，配置文件就是为了使代码更易于被其他开发人员使用和更改。

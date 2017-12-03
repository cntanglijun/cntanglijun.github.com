---
title: JavaScript 数组
tags:
  - es5
  - es6
categories: javascript
date: 2017-09-01 08:01:15
---


JavaScript 中的数组是一种特殊的对象，用来表示偏移量的索引是该对象的属性，索引可能是整数。然而，这些数字索引在内部被转换为字符串类型，这是因为 JavaScript 对象中的属性名必须是字符串。数组在 JavaScript 中只是一种特殊的对象，所以效率上不如其他语言中的数组高。

JavaScript中的数组，严格来说应该称作对象，是特殊的 JavaScript 对象，在内部被归类为数组。由于 Array 在 JavaScript 中被当作对象，因此它有许多属性和方法可以在编程时使用。

<!--more-->

# 创建数组

JavaScript 有多种创建数组的方式，大多数 JavaScript 专家推荐使用 [] 操作符，这种方式被认为效率更高。

## 使用 [] 操作符

```js
var numbers = [];
var numbers = [ 1, 2, 3, 4, 5 ];
```

## 使用 new Array 构造函数

```js
var number = new Array();
// 指定初始值
var number = new Array(1, 2, 3, 4, 5);
// 指定数组长度
var number = new Array(10)
```

## 元素可以是不同类型

```js
var objects = [ 1, 'joe', true, null ];
```
## Array.isArray() 判断是否是数组

```js
var numbers = 3;
var arr = [ 7, 4, 1776 ];
console.log(Array.isArray(numbers)); // false
console.log(Array.isArray(arr)); // true
```

# 数组的使用

## 赋值

```js
var nums = []

for (var i = 0; i < 100; i += 1) {
  nums[i] = i + 1;
}
```

## 取值

```js
var numbers = [ 1, 2, 3, 4, 5 ];
var sum = numbers[0] + numbers[1] +
    numbers[2] + numbers[3] + numbers[4];

console.log(sum); // 15
```

读取所有元素，可以用 for 循环

```js
var numbers = [ 1, 2, 3, 5, 8, 13, 21 ];
var sum = 0;

// 数组的长度可以任意增长，使用 length 属性确保遍历所有元素
for (var i = 0; i < numbers.length; i += 1) {
  sum += numbers[i];
}

console.log(sum); // 53
```

## 字符串生成数组

```js
var sentence = 'Hello World';
var words = sentence.split(' ');

for (var i = 0; i < words; i += 1) {
  console.log('word' + i + ': ' + words[i]);
}
```

## 潜复制

```js
var nums = [];

for (var i = 0; i < 10; i += 1) {
  nums[i] = i + 1;
}

var samenums = nums;
```

数组是引用类型，这种赋值只是为新赋值的数组增加了一个新的引用。

```js
var nums = [];

for (var i = 0; i < 10; i += 1) {
  nums[i] = i + 1;
}

var samenums = nums;
nums[0] = 400;
console.log(samenums[0]); // 400
```

## 深复制

为了达到预期效果，可以写一个深复制函数

```js
function copy(originArr, targetArr) {
  for (var i = 0; i < originArr.length; i += 1) {
    targetArr[i] = originArr[i];
  }
}

var nums = [];

for (var i = 0; i < 10; i += 1) {
  nums[i] = i + 1;
}

var samenums = [];
copy(nums, samenums);
nums[0] = 400;
console.log(samenums[0]); // 1
```

# 存取函数

JavaScript 提供了一组用来访问数组元素的函数，叫做存取函数，这些函数返回目标数组的某种变体。

## 查找元素

```js
var names = [ 'David', 'Cyntha', 'Raymond', 'Clayton', 'Jennifer', 'David' ];
var name = 'David';
//从数组第一个位置开始
var position = names.indexOf(name); // 0
var lastPosition = names.lastIndexOf(name); // 5

if (position >= 0) {
  console.log('找到 ' + name + ' 在位置 ' + position);
} else {
  console.log(name + ' 不在数组内');
}

if (lastPosition >= 0) {
  console.log('找到 ' + name + ' 在位置 ' + lastPosition);
} else {
  console.log(name + ' 不在数组内');
}
```

## 数组转字符串

```js
var names = [ 'David', 'Cyntha', 'Raymond', 'Clayton', 'Jennifer', 'David' ];

var nameStr = names.join();
console.log(nameStr);

nameStr = names.toString();
console.log(nameStr);
```

## 合并数组

```js
var webDept = [ '小明', '张三', '王五' ];
var javaDept = [ '老张', '阿飞' ];
var itDept = webDept.concat(javaDept);
console.log(itDept);
itDept = javaDept.concat(webDept);
console.log(itDept);
console.log(webDept, javaDept);
```

concat 方法返回新数组，源数组不受影响。

## 截取数组

```js
var itDept = [ '小明', '张三', '王五', '老张', '阿飞' ];
var webDept = itDept.splice(0, 3);
var javaDept = itDept;
console.log(webDept); // '小明', '张三', '王五'
console.log(javaDept); // '老张', '阿飞'
console.log(itDept); // '老张', '阿飞'
```

splice 返回截取的元素并删除源数组中的对应的元素。

# 可变函数

JavaScript 拥有一组可变函数，使用它们，可以不必引用数组中的某个元素，就能改变数组内容。这些函数常常化繁为简，让困难的事情变得容易。

## 添加元素

```js
// 使用 push
var nums = [ 1, 2, 3, 4, 5 ];
console.log(nums);
nums.push(6);
console.log(nums);

// 也可以使用 length 属性
nums[nums.length] = 7;
console.log(nums);

// 把元素添加到数组开头使用 unshift
nums.unshift(0);
console.log(nums);

// 任意位置添加元素 splice
nums.splice(2, 0, [ 9, 9, 9 ]);
console.log(nums);

```

## 删除元素

```js
var nums = [ 1, 2, 3, 4, 5, 9 ];

// 删除数组末尾元素
nums.pop();
console.log(nums);

// 删除第一个元素
nums.shift();
console.log(nums);

// 删除任意位置元素
nums.splice(2, 1);
console.log(nums);
```

## 排序

```js
var nums = [ 1, 2, 3, 4, 5 ];
// 元素反转
nums.reverse();
console.log(nums);

// 按字典顺序排序
var names = [ 'David', 'Mike', 'Cyntha', 'Clayton', 'Bryan', 'Raymond' ];
names.sort();
console.log(names);

// 数字排序使用自定义排序
function compare(num1, num2) {
  return num1 - num2;
}

nums = [ 3, 1, 2, 100, 4, 200 ];
nums.sort(compare);
console.log(nums);
```

# 迭代器方法

迭代器方法对数组中的每个元素应用一个函数，可以返回一个值，一组值或者一个新数组。

## forEach()

该方法接受一个函数作为参数，对数组中的每个元素使用该函数。

```js
function square(num) {
  console.log(num, num * num);
}
var nums = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ];
nums.forEach(square);
```

## every()

该方法接受一个返回值为布尔类型的函数，对数组中的每个元素使用该函数。如果对于所有元素，该函数均返回 true,则该方法返回 true。

```js
function isEven(num) {
  return num % 2 === 0;
}
var nums = [ 2, 4, 6, 8, 10 ];
var even = nums.every(isEven);

if (even) {
  console.log('所有元素是偶数');
} else {
  console.log('不是所有元素是偶数');
}

nums = [ 2, 4, 6, 7, 8, 10 ];
even = nums.every(isEven);

if (even) {
  console.log('所有元素是偶数');
} else {
  console.log('不是所有元素是偶数');
}
```

## some()

some() 方法也接受一个返回布尔类型的函数，只要有一个元素使得该函数返回 true，该方法就返回 true。

```js
function isEven(num) {
  return num % 2 === 0;
}
var nums = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ];
var someEven = nums.some(isEven);

if (someEven) {
  console.log('部分元素是偶数');
} else {
  console.log('没有元素是偶数');
}

nums = [ 1, 3, 5, 7, 9 ];
someEven = nums.some(isEven);

if (someEven) {
  console.log('部分元素是偶数');
} else {
  console.log('没有元素是偶数');
}
```

## reduce()

reduce() 方法接受一个函数，返回一个值。该方法会从一个累加值开始，不断对累加值和数组中的后续元素调用该函数，直到数组中的最后一个元素，最后返回得到的累加值。

```js
function add(runningTotal, currentValue) {
  return runningTotal * currentValue;
}
var nums = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ];
var sum = nums.reduce(add);
console.log(sum);

// 连接数组中的字符串
function concat(accumulatedString, item) {
  return accumulatedString + item;
}
var words = [ 'the ', 'quick ', 'brown ', 'fox ' ];
var sentence = words.reduce(concat);
console.log(sentence);
```

## reduceRight()

JavaScript 还提供了 reduceRight() 方法，和 reduce() 方法不同，它是从右到左执行。

```js
function concat(accumulatedString, item) {
  return accumulatedString + item;
}
var words = [ 'the ', 'quick ', 'brown ', 'fox ' ];
var sentence = words.reduceRight(concat);
console.log(sentence);
```

## map()

map() 和 forEach() 有点儿像，对数组中的每个元素使用某个函数。两者的区别是 map() 返回一个新的数组，该数组的元素是对原有元素应用某个函数得到的结果。

```js
function curve(grade) {
  return grade += 5;
}
var grades = [ 77, 65, 81, 92, 83 ];
var newgrades = grades.map(curve);
console.log(newgrades); // 82, 70, 86, 97, 88

// 字符串操作
function first(word) {
  return word[0];
}
var words = ['for', 'your', 'information'];
var acronym = words.map(first);
console.log(acronym.join('')); // 'fyi'
```

## filter()

filter() 和 every() 类似，传入一个返回值为布尔类型的函数。和 every() 方法不同的是，当对数组中的所有元素应用该数组，结果均为 true 时，该方法并不返回 true，而是返回一个新数组，该数组包含应用该函数后结果为 true 的元素。

```js
function isEven(num) {
  return num % 2 === 0;
}
function isOdd(num) {
  return num % 2 !== 0;
}
var nums = [];
for (var i = 0; i < 20; i += 1) {
  nums[i] = i + 1;
}
var evens = nums.filter(isEven);
console.log('偶数是：' + evens);
var odds = nums.filter(odd);
console.log('奇数是：' + odds);

// 筛选成绩 >= 60 分的分数
function passing(num) {
  return num >= 60;
}
var grades = [];
for (var i = 0; i < 20; i += 1) {
  grades[i] = Math.floor(Math.random() * 101);
}
var passGrades = grades.filter(passing);
console.log('所有等级：' + grades);
console.log('通过等级：' + passGrades);

// 过滤字符串数组
function afterc(str) {
  if (str.indexOf('cie') > -1) {
    return true;
  }
  return false;
}
var words = [ 'recieve', 'deceive', 'percieve', 'deceit', 'concieve' ];
var misspelled = words.filter(afterc);
console.log(misspelled); // recieve, percieve, concieve
```

# 多维数组

JavaScript 只支持一维数组，但是通过在数组里保存数组元素的方式，可以轻松创建多维数组。

## 二维数组

### 创建二维数组

```js
var twod = [];
var rows = 5;
for (var i = 0; i < rows; i += 1) {
  twod[i] = [];
}
// 更好的方式可以参考 Crockford 的对 Array 的扩展方法
Array.matrix = function (numrows, numcols, initial) {
  var arr = [];
  for (var i = 0; i < numrows; i += 1) {
    var columns = [];
    for (var j = 0; j < numcols; j += 1) {
      columns[j] = initial;
    }
    arr[i] = columns;
  }
  return arr;
}

var nums = Array.matrix(5, 5, 0);
console.log(nums[1][1]); // 0

var names = Array.matrix(3, 3, '');
names[1][2] = 'Joe'
console.log(names[1][2]); // 'Joe'
```

### 处理二维数组的元素

处理二维数组中的元素，有两种最基本的方式：按列访问和按行访问。

```js
// 按列访问
var grades = [ [ 89, 77, 78 ], [ 76, 82, 81 ], [ 91, 94, 89 ] ];
var total = 0;
var average = 0.0;

for (var row = 0; row < grades.length; row += 1) {
  for (var col = 0; col < grades[row].length; col += 1) {
    total += grades[row][col];
  }
  average = total / grades[row].length;
  console.log('学生 ' + parseInt(row + 1) + ' 平均成绩：' + average.toFixed(2));
  total = 0;
  average = 0.0;
}
```

按行访问，只需要稍微调整 for 循环的顺序，使外层循环对应列，内层循环对应行即可。

```js
// 按行访问
var grades = [ [ 89, 77, 78 ], [ 76, 82, 81 ], [ 91, 94, 89 ] ];
var total = 0;
var average = 0.0;

for (var col = 0; col < grades.length; col += 1) {
  for (var row = 0; row < grades[col].length; row += 1) {
    total += grades[row][col];
  }
  average = total / grades[col].length;
  console.log('考试 ' + parseInt(col + 1) + ' 平均成绩：' + average.toFixed(2));
  total = 0;
  average = 0.0;
}
```

### 参差不齐的数组

参差不齐的数组是指数组中每行的元素个数彼此不同。有一行可能包含三个元素，另一行可能包含五个元素，有些行甚至只包含一个元素。

```js
var grades = [ [ 89, 77 ], [ 76, 82 ], [ 91, 94, 89, 99 ] ];
var total = 0;
var average = 0.0;

for (var row = 0; row < grades.length; row += 1) {
  for (var col = 0; col < grades[row].length; col += 1) {
    total += grades[row][col];
  }
  average = total / grades[row].length;
  console.log('学生 ' + parseInt(row + 1) + ' 平均成绩：' + average.toFixed(2));
  total = 0;
  average = 0.0;
}
```

# 对象数组

数组可以包含对象

```js
function Point(x, y) {
  this.x = x;
  this.y = y;
}
function displayPts(arr) {
  for (var i = 0; i < arr.length; i += 1) {
    console.log(arr[i].x + ', ' + arr[i].y);
  }
}
var p1 = new Point(1, 2);
var p2 = new Point(3, 5);
var p3 = new Point(2, 8);
var p4 = new Point(4, 4);
var points = [ p1, p2, p3, p4 ];

for (var i = 0; i < points.length; i += 1) {
  console.log('点 ' + parseInt(i + 1) + ': ' + points[i].x + ', ' + points[i].y);
}

var p5 = new Point(12, -3);
points.push(p5);

console.log('添加后：');
displayPts(points);
points.shift();
console.log('删除第一个元素后：');
displayPts(points);
```

# 对象中的数组

在对象中，可以使用数组存储复杂的数据。

```js
function weekTemps() {
  this.dataStore = [];
  this.add = add;
  this.average = average;
}
function add(temp) {
  this.dataStore.push(temp);
}
function average() {
  var total = 0;
  for (var i = 0; i < this.dataStore.length; i += 1) {
    total += this.dataStore[i];
  }
  return total / this.dataStore.length;
}

var thisWeek = new weekTemps();

thisWeek.add(52);
thisWeek.add(55);
thisWeek.add(61);
thisWeek.add(65);
thisWeek.add(55);
thisWeek.add(50);
thisWeek.add(52);
thisWeek.add(49);

console.log(thisWeek.average());
```

# 优雅降级

对于一些老的浏览器可以推荐使用 Lodash 库来进行优雅降级。

# 参考资料

* 数据结构与算法 JavaScript 描述
* [Lodash](https://lodash.com/)
* [Array - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)

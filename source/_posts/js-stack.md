---
title: JavaScript 栈
tags:
  - es5
  - es6
categories: javascript
date: 2017-09-03 09:01:50
---


栈与列表类似，可以用来解决计算机世界里的很多问题。栈是一种高效的数据结构，因为数据只能在栈顶添加或删除，所以这样操作很快，而且很容易实现。

<!--more-->

# 栈的抽象数据类型定义

| 成员 | 说明 |
| --- | --- |
| dataStore(属性) | 保存栈内元素的数组 |
| top(属性) | 纪录栈顶位置 |
| push(方法) | 向栈添加新元素 |
| pop(方法) | 返回栈顶元素 |
| peek(方法) | 返回栈顶元素 |
| length(方法) | 返回栈内的元素个数 |
| clear(方法) | 清空栈 |

# 实现栈

```js
function Stack() {
  this.dataStore = [];
  this.top = 0;
  this.push = push;
  this.pop = pop;
  this.peek = peek;
  this.clear = clear;
  this.length = length;
}
function push(element) {
  this.dataStore[this.top++] = element;
}
function peek() {
  return this.dataStore[this.top - 1];
}
function pop() {
  return this.dataStore[--this.top];
}
function clear() {
  this.top = 0;
}
function length() {
  return this.top;
}
```

# 测试

```js
var s = new Stack();
s.push('David');
s.push('Raymond');
s.push('Bryan');
console.log('length: ' + s.length());
console.log(s.peek());
var popped = s.pop();
console.log('栈顶元素是：' + popped);
console.log(s.peek());
s.push('Cynthia');
console.log(s.peek());
s.clear();
console.log('长度：' + s.length());
console.log(s.peek());
s.push('Clayton');
console.log(s.peek());
```

# 使用 Stack 类

有一些问题特别适合用栈来解决。

## 数制间的相互转换

* 最高位为 n % b，将此位压入栈
* 使用 n/b 代替 n
* 重复步骤 1 和 2，直到 n 等于 0，且没有余数
* 持续将栈内元素弹出，直到栈为空，依次将这些元素排列，就得到转换后数字的字符串形式。

> 次算法只针对基数为 2-9 的情况

```js
function mulBase(num, base) {
  var s = new Stack();

  do {
    s.push(num % base);
    num = Math.floor(num /= base);
  } while (num > 0);

  var converted = '';
  while (s.length() > 0) {
    converted += s.pop();
  }
  return converted;
}

var num = 32;
var base = 2;
var newNum = mulBase(num, base);
console.log(num + ' 转为' + base + '进制是 ' + newNum);

num = 125;
base = 8;
newNum = mulBase(num, base);
console.log(num + ' 转为' + base + '进制是 ' + newNum);
```

## 回文

回文是指这样一种现象：一个单词、短语或数字，从前往后写和从后往前写都是一样的。使用栈可以轻松判断一个字符是否是回文。

```js
function isPalindrome(word) {
  var s = new Stack();

  for (var i = 0; i < word.length; i += 1) {
    s.push(word[i]);
  }

  var rword = '';

  while (s.length() > 0) {
    rword += s.pop();
  }

  if (word === rword) {
    return true;
  } else {
    return false;
  }
}

var word = 'hello';

if (isPalindrome(word)) {
  console.log(word + ' 是回文');
} else {
  console.log(word + ' 不是回文');
}

word = 'racecar';

if (isPalindrome(word)) {
  console.log(word + ' 是回文');
} else {
  console.log(word + ' 不是回文');
}
```

## 递归演示

```js
function factorial(n) {
  if (n === 0) {
    return 1;
  } else {
    return n * factorial(n - 1);
  }
}
// 栈模拟阶乘
function fact(n) {
  var s = new Stack();

  while (n > 1) {
    s.push(n--);
  }

  var product = 1;

  while (s.length() > 0) {
    product *= s.pop();
  }

  return product;
}

console.log(factorial(5));
console.log(fact(5));
```

# 参考资料

* 数据结构与算法 JavaScript 描述

---
title: 计算阶乘
tags:
  - es5
  - factorial
categories: javascript
date: 2017-07-22 10:12:34
---


JavaScript 中的阶乘算法

# 递归算法

```js
function factorial(number) {
  if (number === 1) {
    return number
  } else {
    return number * factorial(number - 1)
  }
}
```

## 迭代算法

```js
function factorial(number) {
  var multiplicand = 1

  for (; number > 1; number --) {
    multiplicand *= number
  }

  return multiplicand
}
```

## 利用 reduce() 或 reduceRight() 方法

```js
function factorial(number) {
  var numbers = [];

  for (var i = number; i > 0; i -= 1) {
    numbers.push(i);
  }

  return numbers.reduce(function (accumulator, currentValue) {
    return accumulator * currentValue;
  })
}
```

```js
function factorial(number) {
  var numbers = [];

  for (var i = number; i > 0; i -= 1) {
    numbers.push(i);
  }

  return numbers.reduceRight(function (accumulator, currentValue) {
    return accumulator * currentValue;
  })
}
```

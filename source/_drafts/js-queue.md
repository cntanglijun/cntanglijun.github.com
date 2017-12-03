---
title: javascript 队列
categories: javascript
tags:
  - es5
  - es6
date: 2017-09-04 17:28:18
---

队列是一种列表，不同的是队列只能在队尾插入元素，在队首删除元素。队列是一种先进先出的数据结构。队列的两种主要操错是：向队列中插入新元素和删除队列中的元素。插入操作也叫做入队，删除操作也叫做出队。入队操作在队尾插入新元素，出队操作删除队头的元素。

<!--more-->

# 抽象出 Queue 类

| 成员 | 说明 |
| --- | --- |
| dataStore(属性) | 存储队列元素 |
| enqueue(方法) | 队尾添加一个元素 |
| dequeue(方法) | 删除队首元素 |
| front(方法) | 返回队首元素 |
| back(方法) | 返回队尾元素 |
| toString(方法) | 显示队列内所有元素 |
| empty(方法) | 判断队列是否为空 |

# 用数组实现队列

```js
function Queue() {
  this.dataStore = [];
  this.enqueue = enqueue;
  this.dequeue = dequeue;
  this.front = front;
  this.back = back;
  this.toString = toString;
  this.empty = empty;
}

function enqueue(element) {
  this.dataStore.push(element);
}

function dequeue() {
  return this.dataStore.shift();
}

function front() {
  return this.dataStore[0];
}

function back() {
  return this.dataStore[this.dataStore.length - 1];
}

function toString() {
  var retStr = '';
  for (var i = 0; i < this.dataStore.length; i += 1) {
    retStr += this.dataStore[i] + '\n';
  }
  return retStr;
}

function empty() {
  if (this.dataStore.length === 0) {
    return true;
  } else {
    return false;
  }
}

var q = new Queue();
q.enqueue('Meredith');
q.enqueue('Cynthia');
q.enqueue('Jennifer');
console.log(q.toString());

q.dequeue();
console.log(q.toString());
console.log('队首：' + q.front());
console.log('队尾：' + q.back());
```

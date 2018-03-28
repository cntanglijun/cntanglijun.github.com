---
title: JavaScript 列表
tags:
  - es5
  - es6
categories: javascript
date: 2017-09-02 13:20:39
---


在日常生活中，人们经常使用列表：待办事项列表、购物清单、十佳榜单、最后十名榜单等。计算机程序也在使用列表，尤其是列表中保存的元素不是太多事。当不需要在一个很长的序列中查找元素，或者对其进行排序时，列表显得尤为有用。反之，如果数据结构非常复杂，列表的作用就没有那么大了。

# 列表的抽象数据类型定义

| 成员 | 说明 |
| --- | --- |
| listSize(属性) | 列表的元素个数 |
| pos(属性) | 列表的当前位置 |
| length(属性) | 返回列表中元素的个数 |
| clear(方法) | 清空列表中的所有元素 |
| toString(方法) | 返回列表的字符串形式 |
| getElement(方法) | 返回当前位置的元素 |
| insert(方法) | 在现有元素后插入新元素 |
| append(方法) | 在列表的末尾添加新元素 |
| remove(方法) | 从列表中删除元素 |
| front(方法) | 将列表的当前位置移动到第一个元素 |
| end(方法) | 将列表的当前位置移动到最后一个元素 |
| prev(方法) | 将当前位置后移一位 |
| next(方法) | 将当前位置前移一位 |
| currPos(方法) | 返回列表的当前位置 |
| moveTo(方法) | 将当前位置移动到指定位置 |

# 实现列表类

```js
function List() {
  this.listSize = 0;
  this.pos = 0;
  // 初始化一个空数组来保存列表元素
  this.dataStore = [];
  this.clear = clear;
  this.find = find;
  this.toString = toString;
  this.insert = insert;
  this.append = append;
  this.remove = remove;
  this.front = front;
  this.end = end;
  this.prev = prev;
  this.next = next;
  this.length = length;
  this.currPos = currPos;
  this.moveTo = moveTo;
  this.getElement = getElement;
  this.length = length;
  this.contains = contains;
}

// 实现 append() 方法，当新元素就位后，变量 listSize 加 1
function append(element) {
  this.dataStore[ this.listSize++ ] = element;
}

// 实现 find() 方法，查找元素在列表中的位置
function find(element) {
  for (var i = 0; i < this.dataStore.length; i += 1) {
    if (this.dataStore[i] === element) {
      return i
    }
  }
  return -1;
}

// 实现 remove() 方法，首先使用 find() 方法在列表中找到该元素，然后删除它。
function remove(element) {
  var foundAt = this.find(element);
  if (foundAt > -1) {
    this.dataStore.splice(foundAt, 1);
    --this.listSize;
    return true;
  }
  return false;
}

// 实现 length 方法，返回列表中元素的个数
function length() {
  return this.listSize;
}

// 实现 toString() 方法
function toString() {
  // 严格说来，该方法返回的是一个数组，而不是一个字符串，但它的目的是为了显示列表的当前状态，因此返回一个数组就足够了
  return this.dataStore;
}

// 实现 insert() 方法，使用 find() 方法找到传入参数的位置，然后使用 splice() 方法插入新元素
function insert(element, after) {
  var insertPos = this.find(after);
  if (insertPos > -1) {
    this.dataStore.splice(insertPos + 1, 0, element);
    ++this.listSize;
    return true;
  }
  return false;
}

// 实现 clear() 方法
function clear() {
  delete this.dataStore;
  this.dataStore = [];
  this.listSize = this.pos = 0;
}

// 实现 contains() 方法，判断一个给定值是否在列表中
function contains(element) {
  for (var i = 0; i < this.dataStore.length; i += 1) {
    if (this.dataStore[i] === element) {
      return true;
    }
  }
  return false;
}

// 实现遍历方法
function front() {
  this.pos = 0;
}
function end() {
  this.pos = this.listSize - 1;
}
function prev() {
  if (this.pos > 0) {
    --this.pos;
  }
}
function next() {
  if (this.pos < this.listSize - 1) {
    ++this.pos;
  }
}
function currPos() {
  return this.pos;
}
function moveTo(position) {
  this.pos = position;
}
function getElement() {
  return this.dataStore[this.pos];
}
```

# 测试

```js
var names = new List();

names.append('Cynthia');
names.append('Raymond');
names.append('Barbara');
console.log(names.toString());
names.remove('Raymond');
console.log(names.toString());
```

```js
var names = new List();

names.append('Clayton');
names.append('Raymond');
names.append('Cynthia');
names.append('Jennifer');
names.append('Bryan');
names.append('Danny');

names.front();
console.log(names.getElement());
names.next();
console.log(names.getElement());
names.next();
names.next();
names.prev();
console.log(names.getElement());
```

# 使用迭代器访问列表

使用迭代器，可以不必关心数据的内部存储方式，以实现对列表的遍历。

优点

* 访问列表元素时不必关心底层的数据存储结构
* 当为列表添加一个元素时，索引的值就不对了，此时只用更新列表，而不用更新迭代器
* 可以用不同类型的数据存储方式实现 List 类，迭代器为访问列表里的元素提供了一种统一的方式

```js
for (names.front(); names.currPos() < names.length(); names.next()) {
  console.log(names.getElement());
}
// 从后向前遍历列表
for (names.end(); names.currPos() >= 0; names.prev()) {
  console.log(names.getElement());
}
```

# 参考资料

* 数据结构与算法 JavaScript 描述

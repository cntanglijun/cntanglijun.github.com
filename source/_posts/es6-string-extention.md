---
title: ECMAScript2015(6) String
categories: javascript
tags: es6
date: 2015-12-29 23:04:40
---

ES6 对 String 类做了扩展
<!--more-->

## 新增静态方法

### String.fromCodePoint()

```js
String.fromCodePoint(42);       // "*"
String.fromCodePoint(65, 90);   // "AZ"
String.fromCodePoint(0x404);    // "\u0404"
String.fromCodePoint(0x2F804);  // "\uD87E\uDC04"
String.fromCodePoint(194564);   // "\uD87E\uDC04"
String.fromCodePoint(0x1D306, 0x61, 0x1D307) // "\uD834\uDF06a\uD834\uDF07"

String.fromCodePoint('_');      // RangeError
String.fromCodePoint(Infinity); // RangeError
String.fromCodePoint(-1);       // RangeError
String.fromCodePoint(3.14);     // RangeError
String.fromCodePoint(3e-2);     // RangeError
String.fromCodePoint(NaN);      // RangeError

// String.fromCharCode() alone cannot get the character at such a high code point
// The following, on the other hand, can return a 4-byte character as well as the
// usual 2-byte ones (i.e., it can return a single character which actually has
// a string length of 2 instead of 1!)
console.log(String.fromCodePoint(0x2F804)); // or 194564 in decimal
```

**String.fromCodePoint()** 按参数顺序返回代码点的字符串。如果参数不是有效的 **Unicode** 代码点则抛出 **RangeError**

ES5 中 **String.fromCharCode()** 不能正确获取 32 位 (大于 0xFFFF ) 的 Unicode 代码点, ES6 中 **String.fromCodePoint()** 则可以

更多 **String.fromCodePoint()** 细节请 **[使劲点这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/fromCodePoint)**

## 新增原型方法

### String.prototype.codePointAt()

```js
'ABC'.codePointAt(1);          // 66
'\uD800\uDC00'.codePointAt(0); // 65536

'XYZ'.codePointAt(42); // undefined
```

**String.prototype.codePointAt()** 方法返回字符串指定位置的代码点。如果指定的位置没有匹配的元素，返回 **undefined**

ES5 中 **String.prototype.charCodeAt()** 不能正确返回 32 位 Unicode 字符的代码点，ES6 **String.prototype.codePointAt()** 可以

更多 **String.prototype.codePointAt()** 细节请 **[使劲点这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/codePointAt)**

### String.prototype.startsWith()

```js
var str = "To be, or not to be, that is the question.";

alert(str.startsWith("To be"));         // true
alert(str.startsWith("not to be"));     // false
alert(str.startsWith("not to be", 10)); // true
```

**String.prototype.startsWith()** 方法用来判断当前字符串是否是以另外一个给定的子字符串“开头”的，根据判断结果返回 true 或 false

更多 **String.prototype.startsWith()** 细节请 **[使劲点这里](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/startsWith)**

### String.prototype.endsWith()

```js
var str = "To be, or not to be, that is the question.";

alert( str.endsWith("question.") );  // true
alert( str.endsWith("to be") );      // false
alert( str.endsWith("to be", 19) );  // true
alert( str.endsWith("To be", 5) );   // true
```

**String.prototype.endsWith()** 方法用来判断当前字符串是否是以另外一个给定的子字符串“结尾”的，根据判断结果返回 true 或 false

更多 **String.prototype.endsWith()** 细节请 **[使劲点这里](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/endsWith)**

### String.prototype.includes()

```js
var str = "To be, or not to be, that is the question.";

print(str.contains("To be"));    // true
print(str.contains("question")); // true
print(str.contains("To be", 1)); // false
```

**String.prototype.includes()** 方法判断一个字符串是否被包含在另一个字符串中, 如果是返回 true , 否则返回 false

更多 **String.prototype.includes()** 细节请 **[使劲点这里](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/includes)**

### String.prototype.normalize()

```js
// Initial string

// U+1E9B: LATIN SMALL LETTER LONG S WITH DOT ABOVE
// U+0323: COMBINING DOT BELOW
var str = '\u1E9B\u0323';


// Canonically-composed form (NFC)

// U+1E9B: LATIN SMALL LETTER LONG S WITH DOT ABOVE
// U+0323: COMBINING DOT BELOW
str.normalize('NFC'); // '\u1E9B\u0323'
str.normalize();      // same as above


// Canonically-decomposed form (NFD)

// U+017F: LATIN SMALL LETTER LONG S
// U+0323: COMBINING DOT BELOW
// U+0307: COMBINING DOT ABOVE
str.normalize('NFD'); // '\u017F\u0323\u0307'


// Compatibly-composed (NFKC)

// U+1E69: LATIN SMALL LETTER S WITH DOT BELOW AND DOT ABOVE
str.normalize('NFKC'); // '\u1E69'


// Compatibly-decomposed (NFKD)

// U+0073: LATIN SMALL LETTER S
// U+0323: COMBINING DOT BELOW
// U+0307: COMBINING DOT ABOVE
str.normalize('NFKD'); // '\u0073\u0323\u0307'
```

**String.prototype.normalize()** 方法会按照指定的一种 Unicode 正规形式将当前字符串正规化

参数形式如下：

1. **NFC(default)** - *Normalization Form Canonical Composition*
2. **NFD** - *Normalization Form Canonical Decomposition*
3. **NFKC** - *Normalization Form Compatibility Composition*
4. **NFKD** - *Normalization Form Compatibility Decomposition*

更多 **String.prototype.normalize()** 细节请 **[使劲点这里](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/normalize)** 或 **[这里](http://es6.ruanyifeng.com/#docs/string#normalize)**

### String.prototype.repeat()

```js
"abc".repeat(-1)     // RangeError: repeat count must be positive and less than inifinity
"abc".repeat(0)      // ""
"abc".repeat(1)      // "abc"
"abc".repeat(2)      // "abcabc"
"abc".repeat(3.5)    // "abcabcabc" 参数count将会被自动转换成整数.
"abc".repeat(1/0)    // RangeError: repeat count must be positive and less than inifinity

({toString : () => "abc", repeat : String.prototype.repeat}).repeat(2)    //"abcabc",repeat是一个通用方法,也就是它的调用者可以不是一个字符串对象.
```

**String.prototype.repeat()** 构造并返回一个重复当前字符串若干次数的新字符串

更多 **String.prototype.repeat()** 细节请 **[使劲点这里](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/repeat)**

### String.prototype[@@iterator]()

```js
var string = 'A\uD835\uDC68';

var strIter = string[Symbol.iterator]();

console.log(strIter.next().value); // "A"
console.log(strIter.next().value); // "\uD835\uDC68"
```

```js
var string = 'A\uD835\uDC68B\uD835\uDC69C\uD835\uDC6A';

for (var v of string) {
  console.log(v);
}
// "A"
// "\uD835\uDC68"
// "B"
// "\uD835\uDC69"
// "C"
// "\uD835\uDC6A"
```

**String.prototype[@@iterator]()** 返回一个新的迭代器对象来遍历代码点上的字符串并返回每个代码点对应的字符串

更多 **String.prototype[@@iterator]()** 细节请 **[使劲点这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/%40%40iterator)**

### 资料

* [ECMAScript 6 入门](http://es6.ruanyifeng.com/#docs/string 'ECMAScript 6 入门')
* [MDN String](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String 'MDN String')
# [Understanding ECMAScript 6](https://leanpub.com/understandinges6/read/#leanpub-auto-strings-and-regular-expressions 'Understanding ECMAScript 6')

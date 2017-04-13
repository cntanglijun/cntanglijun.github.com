---
title: javascript中的继承
categories: javascript
tags: es5
date: 2015-09-22 15:45:51
---

在 JavaScript 中继承是一个非常复杂的话题，比其他任何面向对象的语言中的继承都复杂得多。在大多数其他面向对象语言中，继承一个类只需要使用一个关键字即可。与它们不同，在 JavaScript 中要想达到传承公用成员的目的，需要采取一系列措施。更有甚者，JavaScript 属于使用原型式继承的少数语言之一。得益于这种语言的灵活性，你既可使用标准的基于类的继承，也可使用更微妙一些的原型式继承。

<!--more-->

## 为什么需要继承

一般来说，在设计类的时候，我们希望能减少重复性的代码，并且尽量弱化对象间的耦合。使用继承符合前一个设计原则的需要。借助这种机制，你可以在现有类的基础上进行设计并充分利用它们已经具备的各种方法，而对设计进行修改也更为轻松。假设你需要让几个类都拥有一个按特定方式输出类结构的 toString 方法，当然可以用复制加黏贴的办法把定义 toString 方法的代码添加到每一个类中，但这样做的话，每当需要改变这个方法的工作方式时，你将不得不在每一个类中重复同样的修改。反之，如果你先创建一个 toStringProvider 类，然后让那些类继承这个类，那么 toString 这个方法只需在一个地方声明即可。


## 类式继承

JavaScript 可以被装扮成使用类式继承的语言。通过用函数来声明类、用关键字 new 来创建实例，JavaScript 中的对象也能惟妙惟肖地模仿 Java 或 C++ 中的对象。

```js
// Person 类
function Person(name) {
  this.name = name;
}

Person.prototype.getName = function () {
  return this.name;
}
```

首先要做的是创建构造函数。按惯例，其名称就是类名，首字母应大写。在构造函数中，创建实例属性要使用关键字 this。类的方法则被添加到其 prototype 对象中，就像例中的 Person.prototype.getName 那样。要创建该类的实例，只需要结合关键字 new 调用这个构造函数即可

```js
var reader = new Person('John Smith');
reader.getName();
```

然后你可以访问所有的实例属性，也可以调用所有的实例方法。这是 JavaScript 中一个非常简单的类的例子。


### 原型链

创建继承 Person 的类则要复杂一些

```js
// Author类
function Author(name, books) {
  Person.call(this, name);
  this.books = books;
}

Author.prototype = new Person();
Author.prototype.constructor = Author;
Author.prototype.getBooks = function () {
  return this.books;
}
```

让一个类继承另一个类需要用到许多行代码(不像大多数别的面向对象的语言中那样只用一个关键字 extend 即可)。首先要做的是像前一个示例中那样创建一个构造函数。在构造函数中，调用超类的构造函数，并将 name 参数传给它。这行代码需要解释一下。在使用 new 运算符的时候，系统会为你做一些事。它先创建一个空对象，然后调用构造函数，在此过程中这个空对象处于作用域的最前端。而在 Author 函数中调用超类的构造函数时，你必须手工完成同样的任务。Person.call(this, name) 这条语句调用了 Person 构造函数，并且在此过程中让那个空对象(用 this 代表)处于作用域的最前端，而 name 则被作为参数传入。

下一步是设置原型链。尽管相关代码比较简单，但这实际上是一个非常复杂的话题。在访问对象的某个成员时(比如 reader.getName)，如果这个成员未见于当前对象，那么 JavaScript 会在其原型对象中查找它。如果在那个对象中也没有找到，那么 JavaScript 会沿着原型链向上逐一访问每个原型对象，直到找到这个成员(或已经查过原型链最顶端的 Object.prototype 对象)。这意味着为了让一个类继承另一个类，只需将子类的 prototype 设置为指向超类的一个实例即可。这与其他语言中的继承机制迥然不同，可能会非常令人费解，而且有违直觉。

为了让 Author 继承 Person，必须手工将 Author 的 prototype 设置为 Person 的一个实例。最后一个步骤是将 prototype的 constructor 属性重设为 Author (因为把 prototype 属性设置为 Person 的实例时，其 constructor 属性被抹除了)

尽管本例中为实现继承需要额外使用三行代码，但是创建这个新的子类的实例与创建 Person 的实例没什么不同

```js
var author = [];

author[0] = new Author('author1', ['book1']);
author[1] = new Author('author2', ['book2']);

author[1].getName();
author[1].getBooks();
```

由此可见，类式继承的所有复杂性只限于类的声明，创建新实例的过程仍然很简单。

### extend 函数

为了简化类的声明，可以把派生子类的整个过程包装在一个名为 extend 的函数中。它的作用与其他语言中的 extend 关键字类似，即基于一个给定的类结构创建一个新的类

```js
// extend 函数
function extend(subClass, superClass) {
  var F = function () {};
  F.prototype = superClass.prototype;
  subClass.prototype = new F();
  subClass.prototype.constructor = subClass;
}
```

这个函数所做的事与先前我们手工做的一样。它设置了 prototype，然后再将其 constructor 重设为恰当的值。作为一项改进，它添加了一个空函数 F，并将用它创建的一个对象实例插入原型链中。这样做可以避免创建超类的新实例，因为它可能会比较庞大，而且有时超类的构造函数有一些副作用，或者会执行一些需要进行大量计算的任务。

使用了 extend 函数后，前面那个 Person/Author 例子变成了这个样子

```js
// Person类
function Person(name) {
  this.name = name;
}

Person.prototype.getName = function () {
  return this.name;
}

// Author类
function Author(name, books) {
  Person.call(this, name);
  this.books = books;
}

extend(Author, Person);

Author.prototype.getBooks = function () {
  return this.books;
}
```

本例不像先前那样手工设置 prototype 和 constructor 属性，而是通过在类声明之后（在向 prototype 添加任何方法之前）立即调用 extend 函数来达到同样的目的。唯一的问题是超类 (Person) 的名称被固化在了 Author 类的声明之中。更好的做法是像下面这样用一种更具普适性的方式来引用父类

```js
// 改进extend函数
function extend(subClass, superClass) {
  var F = function () {};
  F.prototype = superClass.prototype;
  subClass.prototype = new F();
  subClass.prototype.constructor = subClass;

  subClass.superclass = superClass.prototype;
  if (superClass.prototype.constructor == Object.prototype.constructor) {
    superClass.prototype.constructor = superClass;
  }
}
```

这个版本要长一点，它提供了 superclass 属性，这个属性可以用来弱化 Author 与 Person 之间的耦合。该函数的前面 4 行与前一版本相同。它的最后 3 行代码则用来确保超类原型的 constructor 属性已被正确设置，在用这个新的 superClass 属性调用超类的构造函数时这个问题很重要

```js
function Author(name, books) {
  Author.superclass.constructor.call(this, name);
  this.books = books;
}

extend(Author, Person);

Author.prototype.getBooks = function () {
  return this.books;
}
```

有了 superclass 属性，就可以直接调用超类中的方法。这在既要重定义超类的某个方法而又想访问其在超类中的实现时可以派上用场。例如，为了用一个新的 getName 方法重定义 Person 类中的同名方法，你可以先用 Author.superclass.getName 获得作者的名字，然后在此基础上添加其他信息：

```js
Author.prototype.getName = function () {
  var name = Author.superclass.getName.call(this);
  return name + ', Author of ' + this.getBooks().join(', ');
}
```

## 原型式继承

原型式继承与类式继承截然不同。我们发现在谈到它的时候，最好忘掉自己关于类和实例的一切知识，只从对象的角度来思考。用基于类的办法来创建对象包括两个步骤：首先，用一个类的声明定义对象的结构；第二，实例化该类以创建一个新对象。用这种方式创建的对象都有一套该类所有实例属性的副本。每一个实例方法都只存在一份，但每个对象都有一个指向它的链接。

使用原型式继承时，并不需要用类来定义对象的结构，只需要直接创建一个对象即可。这个对象随后可以被新的对象重用，这得益于原型链查找的工作机制。该对象被成为原型对象 (prototype object) ，这是因为它为其他对象应有的模样提供了一个原型。这正是原型式继承这个名称的由来。

下面我们将使用原型式继承来重新设计 Person 和 Author

```js
var Person = {
  name: 'default name',
  getName: function () {
    return this.name;
  }
};
```

这里并没有使用一个名为 Person 的构造函数来定义类的结构，Person 现在是一个对象字面量。它是所要创建的其他各种类 Person 对象的原型对象。其中定义了所有类 Person 对象都要具备的属性和方法，并为它们提供了默认值。方法的默认值可能不会被改变，而属性的默认值一般都会被改变

```js
var reader = clone(Person);
//输出default name
alert(reader.getName());

reader.name = 'John Smith';
//输出John Smith
alert(reader.getName());
```

clone 函数可以用来创建新的类 Person 对象。它会创建一个空对象，而该对象的原型对象被设置成为 Person。这意味着在这个新对象中查找某个方法或属性时，如果找不到，那么查找过程会在其原型对象中继续进行。

你不必为创建 Author 而定义一个 Person 的子类，只要执行一次克隆即可

```js
// Author原型对象
var Author = clone(Person);
Author.books = [];
Author.getBooks = function () {
  return this.books;
};
```

然后你可以重定义该克隆中的方法和属性。可以修改在 Person 中提供的默认值，也可以添加新的属性和方法。这样一来就创建了一个新的原型对象，你可以将其用于创建新的类 Author 对象

```js
var author = [];
author[0] = clone(Author);
author[0].name = 'Dustin Diaz';
author[0].books = ['JavaScript Design Patterns'];

author[1] = clone(Author);
author[1].name = 'Ross Harmes';
author[1].books = ['JavaScript Design Patterns'];

author[1].getName();
author[1].getBooks();
```

### 对继承而来的成员的读和写的不对等性

前面说过，为了有效地使用原型式继承，你必须忘记有关类式继承的一切。这里就是一个例子。在类式继承中，Author 的每一个实例都有一份自己的 books 数组副本。你可以用代码 author[1].books.push('New Book Title') 为其添加元素。但是对于使用原型式继承方式创建的类 Author 对象来说，由于原型链接的工作方式，这种做法并非一开始就能行得通。一个克隆并非其原型对象的一份完全独立的副本，它只是一个以那个对象为原型对象的空对象而已。克隆刚被创建时，author[1].name 其实是一个返指最初的 Person.name 的链接。对于从原型对象继承而来的成员，其读和写具有内在的不对等性。在读取 author[1].name 的值时，如果你还没有直接为 author[1] 实例定义 name 属性的话，那么所得到的是其原型对象的同名属性值。而在写入 author[1].name 的值时，你是在直接为 author[1] 对象定义一个新属性。

下面这个示例显示了这种不对等性

```js
var authorClone = clone(Author);
// 访问Person.name的值default name
alert(authorClone.name);
// 自身添加name属性
authorClone.name = 'new name';
// 现在访问authorClone.name的值new name
alert(authorClone.name);
// authorClone.books引用的是Author.books。我们只修改了原型对象的默认值，
// 其他继承该对象的对象将得到一个新的默认值为'new book'的books数组
authorClone.books.push('new book');
// 为authorClone自身添加一个新books副本
authorClone.books = [];
// 现在我们修改该数组
authorClone.books.push('new book');
```

这也说明了为什么必须为通过引用传递的数据类型的属性创建新副本。在上面的例子中，向 authorClone.books 数组添加新元素实际上是把这个元素添加到 Author.books 数组中。这可不是什么好事，因为你对那个值的修改不仅会影响到 Author，而且会影响到所有继承了 Author 但还未改写那个属性的默认值的对象。在改变所有那些数组和对象的成员之前，必须先为其创建新的副本。稍不留声，你可能就会忘记这个问题并改动原型对象的值。这种错误必须尽量避免，因为这类问题调式起来会非常费时。在这类场合中，可以使用 hasOwnProperty 方法来区分对象的实际成员和它继承而来的成员。

有时原型对象自己也含有子对象。如果想覆盖其子对象中的一个属性值，你不得不重新创建整个子对象。这可以通过将该子对象设置为一个空对象字面量，然后对其进行重塑而办到。但这意味着克隆出来的对象必须知道其原型对象的每一个子对象的确切结构和默认值。为了尽量弱化对象之间的耦合，任何复杂的子对象都应该使用方法来创建

```js
var CompoundObject = {
  string1: 'default value',
  childObject: {
    bool: true,
    num: 10
  }
};

var compoundObjectClone = clone(CompoundObject);

// 不要这样修改子对象值
compoundObjectClone.childObject.num = 5;

// 好的方式是创建一个新对象，不过需要知道原型对象子对象的确切结构。
// 这就使得原型对象和继承它的对象之间形成了强耦合
compoundObjectClone.childObject = {
  bool: true,
  num: 5
};
```

在这个例子中，为 compoundObjectClone 对象新添加了一个 childObject 属性，并修改了它所指向的对象的 num 属性。问题在于 compoundObjectClone 必须知道 childObject 具有两个默认值分别为 true 和 10 的属性。更好的办法是用一个工厂方法来创建 childObject

```js
var CompoundObject = {};

CompoundObject.string1 = 'default value';
CompoundObject.createChildObject = function () {
  return {
    bool: true,
    num: 10
  };
};
CompoundObject.childObject = CompoundObject.createChildObject();

var compoundObjectClone = clone(CompoundObject);

compoundObjectClone.childObject = CompoundObject.createChildObject();
compoundObjectClone.childObject.num = 5;

```

### clone 函数

在前面的例子中用来创建克隆对象的奇妙函数究竟是个什么样子呢？答案如下

```js
// clone函数
function clone(object) {
  function F() {}
  F.prototype = object;
  return new F;
}
```

clone 函数首先创建了一个新的空函数F，然后将 F 的 prototype 属性设置为作为参数 object 传入的原型对象。由此可以体会到 JavaScript 最初的设计者的用意。prototype 属性就是用来指向原型对象的，通过原型链接机制，它提供了到所有继承而来的成员的链接。该函数最后通过把 new 运算符作用于F创建出一个新对象，然后把这个新对象作为返回值返回。函数所返回的这个克隆结果是一个以给定对象为原型对象的空对象。

## 类式继承和原型式继承的对比

类式继承和原型式继承是大相径庭的两种继承范型，它们生成的对象也有不同的行为方式。两种继承范型都各有其优缺点，为了判断在特定场合下应该使用哪一种，你需要对此有所了解。

包括 JavaScript 程序员在内的整个程序员群体对类式继承都比较熟悉。几乎所有用面向对象方式编写的 JavaScript 代码中都用到了这种继承范型。如果你设计的是一个供众人使用的 API，或者可能会有不熟悉原型式继承的其他程序员基于你的代码进行设计，那么最好还是使用类式继承。在各种流行语言中只有 JavaScript 使用原型式继承，因此可能很多人从来没有用过这种继承。而对象具有到自己的原型对象的反向链接，这也是一个令人困惑的机制。那些没有完全理解原型式继承的程序员会把它视为某种反向继承，即父类继承子类。即使事实并非如此，原型式继承仍然会是一个令人费解话题。但是，因为 JavaScript 中的类式继承仅仅是对真正基于类的继承的一种模仿，所以那些高级 JavaScript 程序员总有一天需要懂得原型式继承的工作机制。有人认为隐瞒这一事实其实是弊大于利。

原型式继承更能节约内存。原型链读取成员的方式使得所有克隆出来的对象都共享每个属性和方法的唯一一份实例，只有在直接设置了某个克隆出来的对象的属性和方法时，情况才会有所变化。与此相比，在类式继承方式中创建的每一个对象在内存中都有自己的一套属性（和私用方法）的副本。原型式继承在这方面的节约效果很突出。这种继承也比类式继承显得更为简练，它只用到了一个 clone 函数，不像后者那样需要为每一个想扩展的类写上好几行像 **SuperClass.call(this, arg)** 和 **SubClass.prototype = new SuperClass** 这样的晦涩代码（当然，这几行代码中的一部分也可以被塞到 extend 函数中）。不要把原型式继承的简洁看作是简陋，它的力量蕴涵在其简洁之中。

该使用类式继承还是原型式继承也许主要还是取决于你更喜欢哪种范型。有些人似乎天生就容易被原型式继承的简洁性吸引，而另一些人却对更面熟的类式继承情有独钟。

## 继承与封装

到目前为止基本没提到过封装对继承的影响。从现有的类派生出一个子类时，只有公用和特权成员会被承袭下来。这与其他面向对象语言中的情况类似。以 Java 为例，其子类就无法访问到父类的私用方法；为了将一个方法遗传给子类，必须在定义它时使用关键字 protected。

由于这个原因，门户大开型类是最适合于派生子类的。它们的所有成员都是公开的，因此可以被遗传给子类。如果某个成员需要稍加隐藏，你可以使用下划线符号规范。

在派生具有真正的私用成员的类时，因为其特权方法是公用的，所以它们会被遗传下来。籍此可以在子类中间接访问父类的私用属性，但子类自身的实例方法都不能直接访问这些私用属性。父类的私用成员只能通过这些既有的特权方法进行访问，你不能在子类中添加能够直接访问它们的新的特权方法。

## 掺元类

有一种重用代码的方法不需要用到严格的继承。如果想把一个函数用到多个类中，可以通过扩充 (augmentation) 的方式让这些类共享该函数。其实际做法大体为：先创建一个包含各种通用方法的类，然后再用它扩充其他类。这种包含通用方法的类称为掺元类 (mixin class)。它们通常不会被实例化或直接调用。其存在的目的只是向其他类提供自己的方法。咱们最好还是用一个示例来演示一下

```js
// 掺元类
var Mixin = function () {};

Mixin.prototype = {
  serialize: function () {
    var output = [];
    for (var key in this) {
      output.push(key + ': ' + this[key]);
    }

    return output.join(', ');
  }
};
```

这个 Mixin 类只有一个名为 serialize 的方法。这个方法遍访this对象的所有成员并将它们的值组织为一个字符串输出（这只是一个简化的例子。更健壮的版本参见 **Douglas Crockford** 的 JSON 库 ([http://json.org/json.js](//json.org/json.js 'http://json.org/json.js')) 中的 toJSONString 方法）。这种方法可能在许多不同类型的类中都会用到，但没有必要让这些类都继承 Mixin，把这个方法的代码复制到这些类中也并不明智。最好还是用 augment 函数把这个方法添加到每一个需要它的类中：

```js
augment(Author, Mixin);

var author = new Author('Ross Harmes', ['JavaScript Design Patterns']);
var serializedString = author.serialize();
```

在此我们用 Mixin 类中的所有方法扩充了 Author 类。Author 类的实例现在就可以调用 serialize 方法了。这可以被视为多亲继承 (multiple inheritance) 在 JavaScript 中的一种实现方式。C++ 和 Python 这类语言允许子类继承多个超类。这在 JavaScript 中是不允许的，因为一个对象只能拥有一个原型对象。不过，由于一个类可以用多个掺元类加以扩充，所以这实际上实现了多继承的效果。

augment 函数很简单。它用一个 for...in 循环遍访予类 (giving class) 的 prototype 中的每一个成员，并将其添加到受类 (receiving class) 的 prototype 中。如果受类中已经存在同名成员，则跳过这个成员，转而处理下一个。受类中的成员不会被改写

```js
// Augment 函数
function augment(receivingClass, givingClass) {
  for(var methodName in givingClass.prototype) {
    if (!receivingClass.prototype[methodName]) {
      receivingClass.prototype[methodName] = givingClass.prototype[methodName];
    }
  }
}
```

这个函数还可以再改进一下。如果掺元类中包含许多方法，但你只想复制其中的一两个，那么上面这个版本的 augment 函数是无法满足需要的。下面的新版本会检查是否存在额外的可选参数，如果存在，则只复制那些名称与这些参数匹配的方法

```js
// 改进版 Augment 函数
function augment(receivingClass, givingClass) {
  if (arguments[2]) {
    for (var i = 2, len = arguments.length; i < len; i += 1) {
      receivingClass.prototype[arguments[i]] = givingClass.prototype[arguments[i]];
    }
  } else {
    for (var methodName in givingClass.prototype) {
      if (!receivingClass.prototype[methodName]) {
        receivingClass.prototype[methodName] = givingClass.prototype[methodName];
      }
    }
  }
}
```

现在就可以用 augment(Author, Mixin, 'serialize');这条语句来达到只为 Author 类添加一个 serialize 方法的目的了。如果想添加更多方法，只要把它们的名称作为参数传入即可。

用一些方法来扩充一个类有时比让这个类继承另一个类更合适。这是一种避免出现重复性代码的轻便的解决方法。不过适合这种方案的场合并不是很多。只有那些通用到足以使其在彼此大不相同的各种类中都能派上用场的方法才适合于共享（要是那些类彼此的差异不是那么大，那么普通的继承往往更合适）。

## 继承的使用场合

继承会使代码变得更加复杂、更难被 JavaScript 新手理解，所以只应该用在其带来的好处胜过缺点的那些场合。它的主要好处表现在代码的重用方面。通过建立类或对象之间的继承关系，有些方法我们只需要定义一次即可。同样，如果需要修改这些方法或排查其中的错误，那么由于其定义只出现在一个位置，所以非常有利于节省时间和精力。

各种继承范型都有自己的优缺点。在内存效率比较重要的场合原型式继承是最佳选择。如果与对象打交道的都是些只熟悉其他面向对象语言中的继承机制的程序员，那么最好使用类式继承。这两种方法都适合于类间差异较小的类层次体系 (hierarchy)。如果类之间的差异较大，那么用掺元类中的方法来扩充这些类往往是一种更合理的选择。

比较简单的JavaScript程序员很少需要用到这种程度的抽象。只有那些有许多程序员参与的大型项目才需要这种代码组织手段。

## 小结

类式继承试图模仿 C++ 和 Java 等面向对象语言中类的继承方式。它最适合于内存效率要求不高或程序员不熟悉那种不太知名的原型式继承的场合。子类派生过程中大多数令人困惑的步骤可以用 extend 函数封装起来。

原型式继承的工作机制是先创建一些对象然后再对其进行克隆，从而得到创建子类和实例的等效结果。一旦你明白了其中的道理，这种继承方式用起来会非常顺手，而且用这种办法创建的对象往往有较高的内存效率，这是因为它们会共享那些未被改写的属性和方法。那些包含着数组或对象类型成员的对象的克隆会有一些麻烦之处，但这个问题可以通过使用一个方法来设置那些属性的默认值加以解决。创建一个克隆对象的所有事宜由 clone 函数负责处理。

掺元类提供了一条既能让对象和类共享一些方法又不需要让它们结成父子关系的途径。如果你想让各种彼此有着较大差异的类共享一些通用方法，那么这正是掺元类的用武之地。augment 函数允许你选择共享掺元类中的全部方法还是部分方法。

使用这三种技术可以创建出复杂的对象层次体系，其简练性堪与任何别的面向对象语言媲美。对于编程新手来说，JavaScript 中的继承不那么好懂或直观。它是一种通过研究这种语言的低层特性而发展起来的高级技术，但是它可以通过使用几个便利函数而得以简化。这种技术非常适用于创建供其他程序员使用的API。

## 在线演示和下载示例代码

* [JavaScript类式继承](http://cntanglijun.github.io/demo/js-inheritance/classical.html 'JavaScript类式继承')
* [JavaScript原型继承](http://cntanglijun.github.io/demo/js-inheritance/prototypal.html 'JavaScript原型继承')
* [JavaScript掺元类](http://cntanglijun.github.io/demo/js-inheritance/mixin.html 'JavaScript掺元类')
* [下载实例代码](http://cntanglijun.github.io/demo/js-inheritance/js-inheritance.7z '下载实例代码')

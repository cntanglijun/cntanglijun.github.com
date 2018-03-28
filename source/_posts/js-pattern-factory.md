---
title: 工厂模式
categories: javascript
tags: es5
date: 2015-11-24 00:37:52
---

一个类或对象中往往会包含别的对象。在创建这种成员对象时，你可能习惯于使用常规方式，也即用 new 关键字和类构造函数。问题在于这会导致相关的两个类之间产生依赖性。我们讲述一种有助于消除这两个类之间的依赖性的模式，它使用一个方法来决定究竟要实例化那个具体的类。我们既要讨论简单工厂模式，也要讨论更复杂的工厂模式。前者另外使用一个类(通常是一个单体)来生成实例，而后者则使用子类来决定一个成员变量应该是哪个具体的类的实例。
<!--more-->

## 简单工厂

最好用一个例子来说明简单工厂模式的概念。假设你想开几个自行车商店，每个店都有几种型号的自行车出售。这可以用一个类来表示：

```js
/*自行车商店类*/
var BicycleShop = function () {};
BicycleShop.prototype = {
  sellBicycle: function (model) {
    var bicycle;
    switch (model) {
      case 'The Speedster':
        bicycle = new Speedster();
        break;
      case 'The Lowrider':
        bicycle = new Lowrider();
        break;
      case 'The Comfort Cruiser':
        break;
      default:
        bicycle = new ComforCruiser();
    }
    Interface.ensuerImplements(bicycle, Bicycle);
    bicycle.assemble();
    bicycle.wash();
    return bicycle;
  }
};
```

sellBicycle 方法根据所要求的自行车型号用 switch 语句创建一个自行车的实例。各种型号的自行车实例可以互换使用，因为它们都实现了 Bicycle 接口：

```js
/*自行车接口*/
var Bicycle = new Interface('Bicycle', ['assemble', 'wash', 'ride', 'repair']);

/*高速自行车接口*/
var Speedster = function () {};
Speedster.prototype = {
  assemble: function () {},
  wash: function () {},
  ride: function () {},
  repair: function () {}
};
```

要出售某种型号的自行车，只要调用 sellBicycle 方法即可：

```js
var californiaCruisers = new BicycleShop();
var yourNewBike = californiaCruisers.sellBicycle('The Speedster');
```

在情况发生变化之前，这倒也挺管用。但要是你想在供货目录中加入一款新车型又会怎么样呢？你得为此修改 BicycleShop 的代码，哪怕这个类的实际功能实际上并没有发生改变--依旧是创建一个自行车的新实例，组装它，清洗它，然后把它交给顾客。更好的解决办法是把 sellBicycle 方法中"创建实例"这部分工作转交给一个简单工厂对象：

```js
/*自行车工厂*/
var BicycleFactory = {
  createBicycle: function (model) {
    var bicycle;
    switch (model) {
      case 'The Speedster':
        bicycle = new Speedster();
        break;
      case 'The Lowrider':
        bicycle = new Lowrider();
        break;
      case 'The Comfort Cruiser':
        break;
      default:
        bicycle = new ComforCruiser();
    }
    Interface.ensuerImplements(bicycle, Bicycle);
    return bicycle;
  }
};
```

BicycleFactory 是一个单体，用来把 createBicycle 方法封装在一个命名空间中。这个方法返回一个实现了 Bicycle 接口的对象，然后你可以照常对其进行组装和清洗:

```js
/*自行车商店类, 改进版*/
var BicycleShop = function () {
  BicycleShop.prototype = {
    sellBicycle: function (model) {
      var bicycle = BicycleFactory.createBicycle(model);
      bicycle.assemble();
      bicycle.wash();
      return bicycle;
    }
  };
}
```

这个 BicycleFactory 对象可以供各种类来创建新的自行车实例。有关可供车型的所有信息都集中在一个地方管理，所以添加更多车型很容易:

```js
/*自行车工厂，添加更多车型*/
var BicycleFactory = {
  createBicycle: function (model) {
    var bicycle;
    switch (model) {
      case 'The Speedster':
        bicycle = new Speedster();
        break;
      case 'The Lowrider':
        bicycle = new Lowrider();
        break;
      case 'The Flatlander':
        break;
      case 'The Comfort Cruiser':
        break;
      default:
        bicycle = new ComforCruiser();
    }
    Interface.ensuerImplements(bicycle, Bicycle);
    return bicycle;
  }
};
```

BicycleFactory 就是简单工厂的一个很好的例子。这种模式把成员对象的创建工作转交给一个外部对象。这个外部对象可以像本例中一样是一个简单的命名空间，也可以是一个类的实例。如果负责创建实例的方法的逻辑不会发生变化，那么一般说来用单体或静态类方法创建这些成员实例是合乎情理的。但如果你要提供几种不同品牌的自行车，那么更恰当的做法是把这个创建方法实现在一个类中，并从该类派生出一些子类。

## 工厂模式

真正的工厂模式与简单工厂模式的区别在于，他不是另外使用一个类或对象来创建自行车(就像前面的例子中所做的那样)，而是使用一个子类。按照正式定义，工厂是一个将其成员对象的实例化推迟到子类中进行的类。我们还是以 BicycleShop 为例来说明简单工厂和工厂模式之间的差别。

我们打算让各个自行车商店自行决定从哪个生产厂家进货。出于这个原因，单单一个 BicycleFactory 对象将无法提供需要的所有自行车实例。我们可以把 BicycleShop 设计为抽象类，让子类根据各自的进货渠道实现其 createBicycle 方法:

```js
/* BicycleShop Class (abstract) */

var BicycleShop = function () {};

BicycleShop.prototype = {
  sellBicycle: function (model) {
    var bicycle = this.createBicycle(model);

    bicycle.assemble();
    bicycle.wash();

    return bicycle;
  },
  createBicycle: function (model) {
    throw new Error('Unsupported operation on an abstract class.');
  }
};
```

这个类中定义了 createBicycle 方法，但真要调用这个方法的话，会抛出一个错误。现在 BicycleShop 是一个抽象类，它不能被实例化，只能用来派生子类。设计一个经销特定自行车生产厂家产品的子类需要扩展 BicycleShop，重定义其中的 createBicycle。下面是两个子类的例子，其中一个子类代表的商店从 Acme 公司进货，而另一个则从 General Products 公司进货:

```js
/* AcmeBicycleShop class */
var AcmeBicycleShop = function () {};

extend(AcmeBicycleShop, BicycleShop);

AcmeBicycleShop.prototype.createBicycle = function (model) {
  var bicycle;

  switch (model) {
    case 'The Speedster':
      bicycle = new AcmeSpeedster();
      break;
    case 'The lowrider';
      bicycle = new AcmeLowrider();
      break;
    case 'The Flatlander':
      bicycle = new AcmeFlatlander();
      break;
    case 'The Comfort Cruiser':
    default:
      bicycle = new AcmeComfortCrusier();
      break;
  }

  Interface.ensureImplements(bicycle, Bicycle);
  return bicycle;
};

/* GeneralProductsBicycleShop class */

var GeneralProductsBicycleShop = function () {};
extend(GeneralProductsBicycleShop, BicycleShop);
GeneralProductsBicycleShop.prototype.createBicycle = function (model) {
  var bicycle;

  switch(model) {
    case 'The Speedster':
      bicycle = new GeneralProductsSpeedster();
      break;
    case 'The Lowrider':
      bicycle = new GeneralProductsLowrider();
      break;
    case 'The Flatlander':
      bicycle = new GeneralProductsFlatlander();
      break;
    case 'The Comfort Cruiser':
    default:
      bicycle = new GeneralProductsComfortCruiser();
      break;
  }

  Interface.ensureImplements(bicycle, Bicycle);
  return bicycle;
}
```

这些工厂方法生成的对象都实现了 Bicycle 接口，所以在其他代码眼里它们完全可以互换。自行车的销售工作还是与以前一样，只是现在所开的商店可以是 Acme 或 General Products 自行车专卖店:

```js
var alecsCruisers = new AcmeBicycleShop();
var yourNewBike = alecsCruisers.sellBicycle('The Lowrider');

var bobsCruisers = new GeneralProductsBicycleShop();
var yourSecondNewBike = bobsCruisers.sellBicycle('The Lowrider');
```

因为两个生产厂家生产的自行车款式完全相同，所以顾客买车时可以不用关心车究竟是哪家生产的。要是他们只想要 Acme 生产的自行车，他们可以去 Acme 专卖店买。

增加对其他生产厂家的支持很简单，只要再创建一个 BicycleShop 的子类并重定义其 createBicycle 工厂方法即可。我们也可以对各个子类进行修改，以支持相关厂家其他型号的产品。这是工厂模式最重要的特点。对 Bicycle 进行一般性操作的代码可以全部写在父类 BicycleShop 中，而对具体的 Bicycle 对象进行实例化的工作则被留到子类中。一般性的代码被集中在一个位置，而个体性的代码则被封装在子类中。

##工厂模式的适用场合

创建新对象最简单的办法是使用 new 关键字和具体类。只有在某些场合下，创建和维护对象工厂所带来的额外复杂性才是物有所值的。

### 动态实现

如果需要像前面自行车的例子一样，创建一些用不同方式实现同一接口的对象，那么可以使用一个工厂方法或简单工厂对象来简化选择实现的过程。这种选择可以是明确进行的也可以是隐含的。前者如自行车那个例子，顾客可以选择需要的自行车型号;之后的 XHR 工厂的例子属于后者，该例中所返回的连接对象的类型取决于所探查到的带宽和网络延时等因素。在这些场合下，你通常要与一系列实现了同一个接口、可以被同等对待的类打交道。这是 JavaScript 中使用工厂模式的最常见的原因。

### 节省设置开销

如果对象需要进行复杂并且彼此相关的设置，那么使用工厂模式可以减少每种对象所需的代码量。如果这种设置只需要为特定类型的所有实例执行一次即可，这种作用尤其突出。把这种设置代码放到类的构造函数中并不是一种高效的做法，这是因为即便设置工作已经完成，每次创建新实例的时候这些代码还是会执行，而且这样做会把设置代码分散到不同的类中。工厂方法非常适合于这种场合。它可以在实例化所有需要的对象的对象之前先一次性地进行设置。无论有多少不同的类会被实例化，这种办法都可以让设置代码集中在一个地方。

如果所用的类要求加载外部库的话，这尤其有用。工厂方法可以对这些库进行检查并动态加载那些未找到的库。这些设置代码只存在于一个地方，因此以后改起来也方便得多。

### 用许多小型对象组成一个大对象

工厂方法可以用来创建封装了许多较小对象的对象。考虑一下自行车对象的构造函数。自行车包含着许多更小的子系统：车轮、车架、传动部件以及车闸等。如果你不想让某个子系统与较大的那个对象之间形成强耦合，而是想在运行时从许多子系统中进行挑选的话，那么工厂方法是一个理想的选择。使用这种技术，某天你可以为售出的所有自行车配上某种链条，要是第二天找到另一种更中意的链条，可以改而采用这个新品种。实现这种改变很容易，因为这些自行车类的构造函数并不依赖于某种特定的链条品种。

## 示例：XHR 工厂

用 Ajax 技术发起异步请求是现在 Web 开发中的一个常见任务。用于发起请求的对象是某种类的实例，具体是哪种类取决于用户的浏览器。如果代码中需要多次执行 Ajax 请求，那么明知的做法是把创建这种对象的代码提取到一个类中，并创建一个包装器来包装在实际发起请求时所要经历的一系列步骤。简单工厂非常适合这种场合，它可以用来根据浏览器能力的不同生成一个 XMLHttpRequest 或 ActiveXObject 实例。

```js
/* AjaxHandler interface */

var AjaxHandler = new Interface('AjaxHandler', ['request', 'createXhrObject']);

/* SimpleHandler class */

var SimpleHandler = function () {}; // implements AjaxHandler

SimpleHandler.prototype = {
  request: function (method, url, callback, postVars) {
    var xhr = this.createXhrObject();
    xhr.onreadystatechange = function () {
      if (xhr.readyState !== 4) return;
      (xhr.status === 200) ? callback.success(xhr.responseText, xhr.responseXML) :
        callback.failure(xhr.status);
    };
    xhr.open(method, url, true);
    if (method !== 'POST') postVars = null;
    xhr.send(postVars);
  },
  // Factory method
  createXhrObject: function () {
    var methods = [
      function () {
        return new XMLHttpRequest();
      },
      function () {
        return new ActiveXObject('Msxml2.XMLHTTP');
      },
      function () {
        return new ActiveXObject('Microsoft.XMLHTTP');
      }
    ];

    for (var i = 0, len = methods.length; i < len; i += 1) {
      try {
        methods[i]()
      } catch (e) {
        continue;
      }

      // if we reach this point, method[i] worked.
      this.createXhrObject = methods[i] //Memoize the method

      return methods[i];
    }

    // if we reach this point, none of the methods worked
    throw new Error('SimpleHandler: Could not create an XHR object.');
  }
};
```

request 这个便利函数负责执行发出请求和处理响应结果所需要的一系列操作。它先创建一个 XHR 对象并对其进行配置，然后再发送请求。这里所关注的是用于创建 XHR 对象的代码。

createXhrObject 这个工厂方法根据当前环境的具体情况返回一个 XHR 对象。在首次执行时，它会依次尝试三种用于创建 XHR 对象的不同方法，一旦遇到一种管用的，它就会返回所创建的对象并将自身改为用以创建那个对象的函数。这个新函数于是摇身一变成了 createXhrObject 方法。这种技术被称为 memoizing，它可以用来创建存储着复杂计算的函数和方法，以免再次进行这种计算。所有那些复杂的设置代码只会在方法首次执行时被调用一次，此后就只有针对当前浏览器的代码会被执行。假如前面的代码运行在一个实现了 XMLHttpRequest 类的浏览器中，那么第二次执行时的 createXhrObject 方法实际上是这个样子：

```js
createXhrObject: function () {return new XMLHttpRequest();}
```

memoizing 技术可以提高代码的效率，因为所有设置和检测代码都只会执行一次。工厂方法是这种代码的理想封装工具，不管代码运行在什么平台上，它都能返回正确的对象。这一任务涉及的复杂性由此被集中在一个地方。

用 SimpleHandler 类发起异步请求的过程很简单，只要创建该类的一个实例，调用它的 request 方法即可：

```js
var myHandler = new SimpleHandler();
var callback = {
  success: function (responseText) {alert('Success: ' + responseText);},
  failure: function (statusCode) {alert('Failure: ' + statusCode);}
};
myHandler.request('GET', 'script.php', callback);
```

### 专用型连接对象

这个例子可以进一步扩展，把工厂模式用在两个地方，以便根据网络条件创建专门的请求对象。在创建 XHR 对象时已经用过了简单工厂模式。另一个工厂则用来返回各种处理器类，它们都派生自 SimpleHandler。

首先要做的是创建两个新的处理器类。QueueHandler 会在发起新的请求之前先确保所有请求都已经成功处理。而 OfflineHandler 则会在用户处于离线状态时把请求缓存起来。

```js
/* QueuedHandler class */
// implements AjaxHandler
var QueueHandler = function () {
  this.queue = [];
  this.requestInProgress = false;
  this.retryDelay = 5; // In seconds.
};
extend(QueueHandler, SimpleHandler);

QueueHandler.prototype.request = function (method, url, callback, postVars, override) {
  if (this.requestInProgress && !override) {
    this.queue.push({
      method: method,
      url: url,
      callback: callback,
      postVars: postVars
    });
  } else {
    this.requestInProgress = true;

    var xhr = this.createXhrObject();
    var that = this;

    xhr.onreadystatechange = function () {
      if (xhr.readyState !== 4) return;
      if (xhr.status === 200) {
        callback.success(xhr.responseText, xhr.responseXML);
        that.advanceQueue();
      } else {
        callback.failure(xhr.status);
        setTimeout(function () {
          that.request(method, url, callback, postVars, true);
        }, that.retryDelay * 1000);
      }
    };

    xhr.open(method, url, true);

    if (method !== 'POST') postVars = null;
    xhr.send(postVars);
  }
};

QueueHandler.prototype.advanceQueue = function () {
  if (this.queue.length !== 0) {
    this.requestInProgress = false;
    return;
  }
  var req = this.queue.shift();
  this.request(req.method, req.url, req.callback, req.postVars, true);
}
```

QueueHandler 的 request 方法与 SimpleHandler 的看上去差不多，但在允许发起新请求之前它会先检查一下，以确保当前没有别的请求正在处理。如果有哪个请求未能成功处理，那么它还会在指定的时间间隔之后再次重复这个请求，直到该请求被成功处理为止。

OfflineHandler 要简单一点：

```js
/* OfflineHandler class. */

// implements AjaxHandler
var OfflineHandler = function () {
  this.storedRequests = [];
};
extend(OfflineHandler, SimpleHandler);
OfflineHandler.prototype.request = function (method, url, callback, postVars) {
  if (XhrManager.isOffline()) {
    // Store the requests until we are online.
    this.storedRequests.push({
      method: method,
      url: url,
      callback: callback,
      postVars: postVars
    });
  } else {
    // Call SimpleHandler's request method if we are online.
    this.flushStoredRequests();
    OfflineHandler.superclass.request(method, url, callback, postVars);
  }
};

OfflineHandler.prototype.flushStoredRequest = function () {
  for (var i = 0, len = this.storedRequest.length; i < len; i += 1) {
    var req = this.storedRequests[i];
  }
  OfflineHandler.superclass.request(req.method, req.url, req.callback, req.postVars);
}
```

XhrManager.isOffline 方法(稍后会详细介绍)的作用在于判断用户是否处于在线状态。OfflineHandler 只有在用户处于在线状态时才会使用 SimpleHandler 的 request 方法实际发起请求。而且一旦探测到用户处于在线状态，它还会立即执行所有缓存中的请求。

### 在运行时选择连接对象

现在该用到工厂模式了。因为程序员根本不可能知道各个最终用户实际面临的网络条件，所以不可能要求他们在开发过程中选择使用哪个处理类，而是应该用一个工厂在运行时选择最合适的类。程序员只需要调用这个工厂方法并使用其返回的对象即可。因为所有这些处理器类都实现了 AjaxHandler 接口，所以它们可以被同等对待。接口是相同的，区别只在于其实现：

```js
/* XhrManager singleton. */
var XhrManager = {
  createXhrHandler: function () {
    var xhr;
    if (this.isOffline()) {
      xhr = new OfflineHandler();
    } else if (this.isHighLatency()) {
      xhr = new QueuedHandler();
    } else {
      xhr = new SimpleHandler();
    }

    Interface.ensureImplements(xhr, AjaxHandler);
    return xhr;
  },
  isOffline: function () {
    // Do a quick request with SimpleHandler and see if it succeeds.
  },
  isHighLatency: function () {
    // Do a series of requests with SimpleHandler and time the responses.Best done once, as a branching function.
  }
};
```

现在程序员就可以使用这个工厂方法，而不必实例化一个特性的类了：

```js
var myHandler = XhrManager.createXhrHandler();
var callback = {
  success: function (responseText) {alert('Success: ' + responseText);},
  failure: function (statusCode) {alert('Failure: ' + statusCode)};
};
myHandler.request('GET', 'script.php', callback);
```

createXhrHandler 方法返回的各种对象都具有我们所需要的一些方法。而且，因为它们都派生自 SimpleHandler，所以 createXhrObject这个复杂的方法只需要在这个类中实现一次即可，那些子类可以使用这个方法。OfflineHandler 中还有多出使用了 SimpleHandler的 request，这进一步实现了代码的重用。

这里省略了 isOffline 和 isHighLatency 方法的实现细节。在实际实现这些方法的时候，需要先编写一个方法，它会用 setTimeout 安排执行一些异步请求，并记录它们的往返时间。只要这些请求中的任何一个得到回应，isOffline 方法就会返回 false，否则它会返回 true。而 isHighLatency 方法会检查请求得到回应所经历的时间，并根据其长短来决定该返回 true 还是 false。这些方法的具体实现都是些细枝末节，这里不在赘述。

## 示例：RSS 阅读器

下面要设计的是一个用来在网页上显示来自 RSS 源的最新信息的小工具。我们打算重用一些现有模块，比如前面例子中的 XHR 处理器，而不是从头做起。最终得到的是一个 RSS 阅读器对象，它的成员对象包括一个 XHR 处理器对象、一个显示对象以及一个配置对象。

由于我们只想跟 RSS 容器对象打交道，所以用一个工厂来实例化这些内部对象并把他们组装到一个 RSS 阅读器对象中。使用工厂方法的好处在于，我们创建的 RSS 阅读器类不会与那些成员对象紧密耦合在一起。我们可以使用任何一个显示模块，只要它实现了必要的方法就行，因此大可不必让阅读器类套牢在某个特定的显示类上。

有了这个工厂方法，只要愿意，我们可以随时换掉任何一个模块，不管是在开发期间还是在运行期间。使用这个 API 的程序员得到的还是一个完整的 RSS 阅读器对象，其中所有的成员对象都已经实例化并配置完毕，但其中涉及的类之间的耦合都比较松散，因此可以随意更换。

先来看看要在工厂方法中进行实例化的那些类。XHR 处理器类你已经见过了。本例使用 XhrManager.createXhrHandler 方法创建所用的处理器对象。下一个类是显示类。为了满足 RSS 阅读器类的需要，它需要实现几个方法。下面是一个实现了那些方法的显示类，它把输出内容包装为一个序列表：

```js
/* 显示模块接口 */
var DisplayModule = new Interface('DisplayModule', ['append', 'remove', 'clear']);

/* 列表展示类 */
var ListDisplay = function(id, parent) {
  this.list = document.createElement('ul');
  this.list.id = id;
  parent.appendChild(this.list);
};

ListDisplay.prototype = {
  append: function (text) {
    ver newEl = document.createElement('li');
    this.list.appendChild(newEl);
    newEl.innerHTML = text;
    return newEl;
  },
  remove: function (el) {
    this.list.removeChild(el);
  },
  clear: function () {
    this.list.innerHTML = '';
  }
};
```

下一个要用到的是配置对象。这只是一个对象字面量，它包含着一些供阅读器类及其成员对象使用的设置：

```js
/* 配置对象 */
var conf = {
  id: 'cnn-top-stories',
  feedUrl: 'http://rss.cnn.com/rss/cnn_topstories.rss',
  updateInterval: 60,
  parent: $('feed-readers')
};
```

这些类都由一个名为 FeedReader 的类组合使用。它用 XHR 处理器从 RSS 源获取 XML 格式的数据并用一个内部方法对其进行解析，然后用显示模块将解析出来的信息输出到网页上：

```js
/* FeedReader 类 */
var FeedReader = function (display, xhrHandler, conf) {
  this.display = display;
  this.xhrHandler = xhrHandler;
  this.conf = conf;
  this.startUpdates();
};
FeedReader.prototype = {
  fetchFeed: function () {
    var that = this;
    var callback = {
      success: function (text, xml) {
        that.parseFeed(text, xml);
      },
      failure: function (status) {
        that.showError(status);
      }
    };

    this.xhrHandler.request('GET', 'feedProxy.php?feed=' + this.conf.feedUrl, callback);
  },
  parseFeed: function (responseText, responseXML) {
    this.display.clear();
    var items = responseXML.getElementsByTagName('item');
    for (var i = 0, len = items.length; i < len; i += 1) {
      var title = items[i].getElementsByTagName('title')[0];
      var link = items[i].getElementsByTagName('link')[0];
      this.display.append('<a href="' + link.firstChild.data + '">' + title.firstChild.data + '</a>');
    }
  },
  showError: function (statusCode) {
    this.display.clear();
    this.display.append('Error fetching feed.');
  },
  stopUpdates: function () {
    clearInterval(this.interval);
  },
  startUpdates: function () {
    this.fetchFeed();
    var that = this;
    this.interval = setInterval(function () {
      that.fetchFeed();
    }, this.conf.updateInterval * 1000);
  }
}
```

XHR 请求中使用的 feedProxy.php 脚本是一个代理。可以用它从外部域获取数据，以应对 JavaScript 的同源限制机制。那种允许从任何 URL 获取数据的开放性代理容易被滥用，因此应该避免使用。像本例中这样使用代理时，应该硬性设定一个允许访问的 URL 的白名单 (whitelist)，拒绝对未列入其中的 URL 的访问。

现在还差一个部分，即把所有这些类和对象拼装起来的那个工厂方法。它被实现为一个简单工厂：

```js
var FeedManager = {
  createFeedReader: function (conf) {
    var displayModule = new ListDisplay(conf.id + '-display', conf.parent);
    Interface.ensureImplements(displayModule, DisplayModule);

    var xhrHandler = XhrManager.createXhrHandler();
    Interface.ensureImplements(xhrHandler, AjaxHandler);

    return new FeedReader(displayModule, xhrHandler, conf);
  }
}
```

这个工厂方法先实例化所需要的模块，确认它们实现正确的方法，然后把它们传递给 FeedReader 构造函数。

这个示例中的工厂方法能带来什么好处呢？使用这个API的程序员当然可以手工创建一个 FeedReader 对象，而不必借助 FeedManager.createFeedReader 方法。但使用这个工厂方法，可以把 FeedReader 类所需要的复杂设置封装起来，并且可以确保其成员对象都实现了所需接口。它还把对所使用的特定模块的硬性设定 (ListDisplay和XhrManager.createXhrHandler) 集中在一个位置。哪天要是想使用 ParagraphDisplay 和 QueuedHandler ，做起来也同样简单，只要改改这个工厂方法内部的代码就行。你也可以添加一些代码，像 XHR 处理器示例中所示的那样在运行期间从一些可用的模块中进行选择。总而言之，这是一个阐明"用许多小型对象组成一个大对象"这个用途的绝佳示例。它使用工厂模式，先创建出所有要用到的对象，然后再生成并返回那个作为容器的 FeedReader 类型大对象。

## 工厂模式之利

工厂模式的主要好处在于消除对象间的耦合。通过使用工厂方法而不是 new 关键字及具体类，你可以把所有实例化代码集中在一个位置。这可以大大简化更换所用的类或在运行期间动态选择所用的类的工作。在派生子类时它也提供了更大的灵活性。使用工厂模式，你可以先创建一个抽象的父类，然后在子类中创建工厂方法，从而把成员对象的实例化推迟到更专门化的子类中进行。

所有这些好处都与面向对象设计的这两条原则有关：弱化对象间的耦合;防止代码的重复。在一个方法中进行类的实例化，可以消除重复性的代码。这是在用一个对接口的调用取代一个具体的实现。这些都有助于创建模块化的代码。

## 工厂模式之弊

可能有人禁不住想把工厂方法当万金油用，把普通的构造函数扔在一边。这并不值得提倡。如果根本不可能另外换用一个类，或者不需要在运行期间在一系列可互换的类中进行选择，那就不应该使用工厂方法。大多数类最好使用 new 关键字和构造函数公开地进行实例化。这可以让代码更简单易读。你可以一眼就看到调用的是什么构造函数，而不必去查看某个工厂方法以便知道实例化的是什么类。工厂方法在其适用场合非常有用，但切勿滥用。如果拿不定主意，那就不要用，因为以后在重构代码时还有机会使用工厂模式。

## 小结

我们讨论了简单工厂和工厂模式。我们以自行车商店为例说明了二者之间的差别：简单工厂通常另外使用一个类或对象封装实例化操作，而真正的工厂模式则要实现一个抽象的工厂方法并把实例化工作推迟到子类中进行。这种模式有几种明确的应用场合。它主要用在所实例化的类的类型不能在开发期间确定，而只能在运行期间确定的情况下。此外，如果存在着许多具有复杂的设置开销的相关对象，或者想创建一个包含了一些成员对象的类但又想避免把它们紧密耦合在一起的话，那么这也是这种模式的用武之地。不要盲目地把工厂模式用于所有的实例化任务。但如果运用得当的话，它将是 JavaScript 程序员手中的一大利器。

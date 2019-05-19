---
title: Web 前端 Ajax 单元测试
tags: unit test
categories: architect
date: 2019-05-19 12:55:46
---


Web 前端与后端交互一般通过 `Ajax` 技术，那么 Ajax 如何来做单元测试呢？

<!-- more -->

# 环境与框架

首先我们要进行技术选型，确定单元测试运行环境和技术栈框架

## 环境

* [nodejs](https://nodejs.org/en/) - 10.15.1

## 技术栈框架

* [karma](https://karma-runner.github.io/latest/index.html) - 4.1.0
  * karma-babel-preprocessor - 8.0.0
  * karma-mocha - 1.3.0
  * karma-mocha-reporter - 2.2.5
  * karma-webpack - 3.0.5
  * karma-phantomjs-launcher - 1.0.4
* [mocha](https://mochajs.org) - 6.1.4
* [webpack](https://webpack.js.org/) - 4.31.0
* [babel](https://babeljs.io/)
  * @babel/core - 7.4.4
  * @babel/preset-env - 7.4.4
  * @babel/polyfill - 7.4.4
  * @babel/plugin-transform-async-to-generator - 7.4.4
* [chai](https://www.chaijs.com/) - 4.2.0
* [axios](https://github.com/axios/axios) - 0.18.0

# 演示项目

我们测试获取 `Github` 上星星数大于 20 万的仓库的接口返回数据，已知接口返回格式如下：

```js
{
  incomplete_results: false,
  items: [
    {
      // ...
    },
    {
      // ...
    }
  ],
  total_count: 2
}
```

我们需要关注的是：

* 接口返回数据中是否包含 `items`，`total_count` 字段
* `items` 是一个数组
* `total_count` 是一个数字
* `items` 的数组长度等于 `total_count` 的值

## package.json

`npm init -y` 创建 `package.json` 文件并在 `package.json` 中添加依赖包

```json
"scripts": {
  "test": "karma start"
},
"devDependencies": {
  "@babel/core": "^7.4.4",
  "@babel/plugin-transform-async-to-generator": "^7.4.4",
  "@babel/preset-env": "^7.4.4",
  "babel-loader": "^8.0.6",
  "chai": "^4.2.0",
  "karma": "^4.1.0",
  "karma-babel-preprocessor": "^8.0.0",
  "karma-mocha": "^1.3.0",
  "karma-mocha-reporter": "^2.2.5",
  "karma-phantomjs-launcher": "^1.0.4",
  "karma-webpack": "^3.0.5",
  "mocha": "^6.1.4",
  "webpack": "^4.31.0"
},
"dependencies": {
  "@babel/polyfill": "^7.4.4"
}
```

## karma.conf.js

运行 `node_modules/.bin/karma init` 创建 `karma.conf.js`

```js
// Karma configuration
// Generated on Sat May 18 2019 22:16:40 GMT+0800 (China Standard Time)

module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '.',


    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: [ 'mocha' ],


    // list of files / patterns to load in the browser
    files: [
      'node_modules/@babel/polyfill/dist/polyfill.js',
      'test/test.*.js'
    ],


    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      'test/test.*.js': [
        'webpack'
      ]
    },


    webpack: {
      devtool: 'inline-source-map',
      mode: 'development',
      stats: 'none',
      module: {
        rules: [
          {
            test: /\.js$/,
            exclude: /node_modules/,
            use: {
              loader: 'babel-loader'
            }
          }
        ]
      }
    },


    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: [
      'mocha'
    ],


    // web server port
    port: 8080,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: false,


    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: [ 'PhantomJS' ],


    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: true,

    // Concurrency level
    // how many browser should be started simultaneous
    concurrency: Infinity
  })
}
```

`preprocessors` 使用 `webpack` 打包整个依赖链生成浏览器可以运行的测试代码。

`singleRun` 设置为 `true` 测试运行结束后自动退出。

## babel.config.js

创建 `babel.config.js`，配置如下

```js
module.exports = {
  presets: [
    [
      '@babel/preset-env',
      {
        modules: false
      }
    ]
  ],

  plugins: [
    '@babel/plugin-transform-async-to-generator'
  ]
}
```

`@babel/plugin-transform-async-to-generator` 用于对 `async`，`await` 进行转码

## test.ajax.js

一般我们将测试文件放在 `test` 文件夹中，创建 `test` 文件夹并新建 `test.ajax.js`

```js
import axios from 'axios'
import { expect } from 'chai'

describe('Testing about geting the repositories that stars greater than 200000', function () {
  const apiUrl = 'https://api.github.com/search/repositories'

  let res = null

  before(async function () {
    console.log(JSON.stringify({
      incomplete_results: false,
      total_count: 2,
      items: [
        {
          // ...
        },
        {
          // ...
        }
      ]
    }, null, 2))

    res = await axios.get(apiUrl, {
      params: {
        q: 'stars:>200000'
      }
    }).then(res => res.data)
  })

  describe('Check the response data', function () {
    it('Should be an object', function () {
      expect(res).to.be.a('object')
    })

    it('Should have property total_count', function () {
      expect(res).to.have.property('total_count')
    })

    it('Should have property items', function () {
      expect(res).to.have.property('items')
    })

    describe('Check the property total_count & items', function () {
      it('Should be a number', function () {
        expect(res.total_count).to.be.a('number')
      })

      it('Should be a array', function () {
        expect(res.items).to.be.a('array')
      })

      it('The length of items should equal total_count', function () {
        expect(res.items.length).to.equal(res.total_count)
      })
    })
  })
})
```

## 测试结果

```
START:
(node:57604) DeprecationWarning: Tapable.plugin is deprecated. Use new API on `.hooks` instead
i ｢wdm｣: Hash: 9d2c943b68425fd58dd0
Version: webpack 4.31.0
Time: 11109ms
Built at: 05/19/2019 12:45:44 PM
i ｢wdm｣: Compiled successfully.
i ｢wdm｣: Compiling...
i ｢wdm｣: Hash: c71383ea847fa44c764d
Version: webpack 4.31.0
Time: 13238ms
Built at: 05/19/2019 12:45:46 PM
            Asset      Size          Chunks             Chunk Names
test\test.ajax.js  1.03 MiB  test\test.ajax  [emitted]  test\test.ajax
Entrypoint test\test.ajax = test\test.ajax.js
[./node_modules/assertion-error/index.js] 2.37 KiB {test\test.ajax} [built]
[./node_modules/axios/index.js] 40 bytes {test\test.ajax} [built]
[./node_modules/axios/lib/axios.js] 1.34 KiB {test\test.ajax} [built]
[./node_modules/axios/lib/cancel/Cancel.js] 385 bytes {test\test.ajax} [built]
[./node_modules/axios/lib/cancel/CancelToken.js] 1.21 KiB {test\test.ajax} [built]
[./node_modules/axios/lib/cancel/isCancel.js] 102 bytes {test\test.ajax} [built]
[./node_modules/axios/lib/core/Axios.js] 2.14 KiB {test\test.ajax} [built]
[./node_modules/axios/lib/defaults.js] 2.38 KiB {test\test.ajax} [built]
[./node_modules/axios/lib/helpers/bind.js] 256 bytes {test\test.ajax} [built]
[./node_modules/axios/lib/helpers/spread.js] 564 bytes {test\test.ajax} [built]
[./node_modules/axios/lib/utils.js] 7.36 KiB {test\test.ajax} [built]
[./node_modules/chai/index.js] 40 bytes {test\test.ajax} [built]
[./node_modules/chai/lib/chai.js] 1.23 KiB {test\test.ajax} [built]
[./node_modules/chai/lib/chai/assertion.js] 5.59 KiB {test\test.ajax} [built]
[./test/test.ajax.js] 2.27 KiB {test\test.ajax} [built]
    + 52 hidden modules
i ｢wdm｣: Compiled successfully.
19 05 2019 12:45:46.787:INFO [karma-server]: Karma v4.1.0 server started at http://0.0.0.0:8080/
19 05 2019 12:45:46.789:INFO [launcher]: Launching browsers PhantomJS with concurrency unlimited
19 05 2019 12:45:46.847:INFO [launcher]: Starting browser PhantomJS
19 05 2019 12:45:50.080:INFO [PhantomJS 2.1.1 (Windows 8.0.0)]: Connected on socket JZtc4FkMxDeeNP59AAAA with id 19235176
  Testing about geting the repositories that stars greater than 200000
    Check the response data
      √ Should be an object
      √ Should have property total_count
      √ Should have property items
      Check the property total_count & items
        √ Should be a number
        √ Should be a array
        √ The length of items should equal total_count

Finished in 0.954 secs / 0.007 secs @ 12:45:52 GMT+0800 (China Standard Time)

SUMMARY:
√ 6 tests completed
```

# 完整 Demo 下载

下载 [ajax-unit-test-demo](/downloads/ajax-unit-test-demo.zip)

# 参考资料

* [https://karma-runner.github.io/latest/index.html](https://karma-runner.github.io/latest/index.html)

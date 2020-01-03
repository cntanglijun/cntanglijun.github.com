---
title: VUE 单元测试
categories: architect
tags:
  - unit test
---

养成良好的编码习惯，一个合格的程序员需要掌握一些编写单元测试的能力。单元测试也可以整体上提升我们的代码质量，这里介绍下 VUE 组件的单元测试。

<!--more-->

> 如果想直接通过 Demo 学习，可以跳过下面的内容，[点击这里下载示例](https://github.com/cntanglijun/vue-boilerplate/archive/master.zip)

## 技术栈

* @vue/test-utils[1.0.0-beta.30]
* istanbul-instrumenter-loader[3.0.1]
* karma[4.4.1]
* karma-chrome-launcher[3.1.0]
* karma-mocha[1.3.0]
* karma-sourcemap-loader[0.3.7]
* karma-coverage-istanbul-reporter[2.1.1]
* karma-webpack[4.0.2]
* webpack[4.41.5]

## 定义配置文件

`karma.conf.js` 文件用于 `karma` 的配置，使用 `node_modules/.bin/karma init` 命令创建该文件，我们定义如下配置：

```js
// Karma configuration
// Generated on Thu Jan 02 2020 15:03:54 GMT+0800 (GMT+08:00)

const webpackConfig = require('./config/webpack.test.config.js')

module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '.',

    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: [ 'mocha' ],

    // list of files / patterns to load in the browser
    files: [ 'test/**/*.spec.js' ],

    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      '**/*.spec.js': [ 'webpack','sourcemap' ]
    },

    // webpack config
    webpack: webpackConfig,

    // web server port
    port: 9876,

    // enable / disable colors in the output (reporters and logs)
    colors: true,

    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,

    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,

    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: [ 'Chrome' ],

    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: false,

    // Concurrency level
    // how many browser should be started simultaneous
    concurrency: Infinity
  })
}
```

* 设置 `frameworks` 为 `['mocha']`，即使用 `mocha` 测试框架
* 设置 `files` 为 `['test/**/*.spec.js']`，即对 `test` 目录下所有的后缀为 `.spec.js` 文件测试
* 设置 `preprocessors` 为 `{'**/*.spec.js': ['webpack', 'sourcemap']}`，即使用 `webpack`，`sourcemap` 对所有的测试文件进行 webpack 打包
* 设置 `browsers` 为 `Chrome`，即使用 Chrome 浏览器作为测试浏览器

## 编写测试用例

详细的关于 `@vue/test-utils` 用法，查看 [https://vue-test-utils.vuejs.org/zh/](https://vue-test-utils.vuejs.org/zh/)

```js
import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import Header from '../src/components/Header'

describe('Header', () => {
  const wrapper = shallowMount(Header)
  const header = wrapper.find('header')
  const h1 = wrapper.find('h1')

  it('有 header 标签', () => {
    expect(header.exists()).to.be.true
  })

  it('有 h1 标签', () => {
    expect(h1.exists()).to.be.true
  })

  it('h1 的文案为“VUE 单页模版”', () => {
    expect(h1.text()).to.equal('VUE 单页模版')
  })

  it('h1 标签在 header 标签中', () => {
    expect(header.contains('h1')).to.be.true
  })
})
```

这里我引用 [vue-boilerplate](https://github.com/cntanglijun/vue-boilerplate) 的 `Header` 组件测试用例

* 首先通过 `shallowMount` 获取 `wrapper`
* 使用 `chai` 断言库编写相关的测试用例

## 运行结果

```txt
i ｢wdm｣: Hash: 33f2ae8f2088d2977880
Version: webpack 4.41.5
Time: 1785ms
Built at: 2020-01-02 19:00:36
              Asset      Size  Chunks             Chunk Names
        1.bundle.js  65.9 KiB       1  [emitted]
        2.bundle.js  31.9 KiB       2  [emitted]
            main.js   415 KiB       0  [emitted]  main
test\Header.spec.js  1.29 MiB       3  [emitted]  test\Header.spec
Entrypoint main = main.js
Entrypoint test\Header.spec = test\Header.spec.js
 [0] ./src/main.js 301 bytes {0} [built]
 [1] ./node_modules/vue/dist/vue.esm.js 319 KiB {0} {3} [built]
 [2] (webpack)/buildin/global.js 472 bytes {0} {3} [built]
 [3] ./node_modules/timers-browserify/main.js 1.97 KiB {0} {3} [built]
 [5] ./node_modules/process/browser.js 5.29 KiB {0} {3} [built]
 [6] ./src/App.vue 966 bytes {0} [built]
 [7] ./src/App.vue?vue&type=template&id=7ba5bd90& 195 bytes {0} [built]
 [9] ./node_modules/vue-loader/lib/runtime/componentNormalizer.js 2.63 KiB {0} {3} [built]
[10] ./src/router.js 381 bytes {0} [built]
[11] ./node_modules/vue-router/dist/vue-router.esm.js 72 KiB {0} [built]
[12] ./src/pages/Home/index.vue 1.37 KiB {1} [built]
[20] ./src/components/Header/index.vue 1.2 KiB {1} {2} {3} [built]
[56] ./test/Header.spec.js 665 bytes {3} [built]
[57] ./node_modules/chai/index.js 40 bytes {3} [built]
[95] ./node_modules/@vue/test-utils/dist/vue-test-utils.js 382 KiB {3} [built]
    + 82 hidden modules
i ｢wdm｣: Compiled successfully.
02 01 2020 19:00:37.446:INFO [karma-server]: Karma v4.4.1 server started at http://0.0.0.0:9876/
02 01 2020 19:00:37.454:INFO [launcher]: Launching browsers Chrome with concurrency unlimited
02 01 2020 19:00:37.469:INFO [launcher]: Starting browser Chrome
02 01 2020 19:00:40.606:INFO [Chrome 79.0.3945 (Windows 10.0.0)]: Connected on socket KdneZ66Ws38cHm1mAAAA with id 77158009

  Header
    √ 有 header 标签
    √ 有 h1 标签
    √ h1 的文案为“VUE 单页模版”
    √ h1 标签在 header 标签中

Chrome 79.0.3945 (Windows 10.0.0): Executed 4 of 4 SUCCESS (0.021 secs / 0.004 secs)
TOTAL: 4 SUCCESS
```

可以看到我们的单元测试已经通过了

## 测试覆盖率报告

测试完成后，我们需要查看测试覆盖率报告。这需要在 `webpack.test.config.js` 和 `karma.conf.js` 中做一些配置修改

### webpack.test.config.js

```js
const merge = require('webpack-merge')
const path = require('path')
const webpackCommonConfig = require('./webpack.common.config')

const testConfig = {
  devtool: 'inline-source-map',
  mode: 'none',
  module: {
    rules: [
      {
        test: /\.js$/i,
        enforce: 'pre',
        use: [
          {
            loader: 'istanbul-instrumenter-loader',
            options: {
              esModules: true
            }
          }
        ]
      }
    ]
  }
}

module.exports = merge(webpackCommonConfig, testConfig)
```

* 添加一个优先执行的编译 `.js` 文件的 `rules`，`loader` 使用 `istanbul-instrumenter-loader` 并开启 `esModules` 模式

### karma.conf.js

```js
module.exports = function(config) {
  config.set({

    // ...

    coverageIstanbulReporter: {
      reports: [ 'html', 'text-summary' ],
      fixWebpackSourcePaths: true
    },

    reporters: [ 'coverage-istanbul' ]

    //...

  })
}
```

* 设置 `reporters` 为 `[ 'coverage-istanbul' ]`，即使用 `coverage-istanbul` reporters
* `coverageIstanbulReporter` 配置项用于设置 `coverage-istanbul` 的参数，详细的参数可以参考 [这里](https://github.com/mattlewis92/karma-coverage-istanbul-reporter#configuration)

### 运行结果

再次执行单元测试，我们会看到测试覆盖率的摘要

```txt
=============================== Coverage summary ===============================
Statements   : 100% ( 12/12 )
Branches     : 100% ( 0/0 )
Functions    : 100% ( 5/5 )
Lines        : 100% ( 12/12 )
================================================================================
```

也可以通过生成到 `coverage` 目录下的网页文件，在浏览器中查看

![](./coverage.png)

## 参考资料

* [https://vue-test-utils.vuejs.org/zh/](https://vue-test-utils.vuejs.org/zh/)
* [https://github.com/mattlewis92/karma-coverage-istanbul-reporter](https://github.com/mattlewis92/karma-coverage-istanbul-reporter)

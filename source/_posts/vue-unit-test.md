---
title: VUE 单元测试
tags:
  - unit test
categories: architect
date: 2020-01-03 15:44:19
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

const webpackConfig = require('./config/webpack.test.config.js')

module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '.',

    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: [ 'mocha' ],

    // list of files / patterns to load in the browser
    files: [
      'test/**/*.spec.js'
    ],

    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      'test/**/*.spec.js': [ 'webpack', 'sourcemap' ]
    },

    // webpack config
    webpack: webpackConfig,

    webpackMiddleware: {
      stats: 'errors-only'
    },

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

这里我引用 [vue-single-page](https://github.com/cntanglijun/web-building-boilerplates/blob/master/vue-single-page/src/components/Header/index.vue) 的 `Header` 组件测试用例

* 首先通过 `shallowMount` 获取 `wrapper`
* 使用 `chai` 断言库编写相关的测试用例

## 运行结果

```txt
i ｢wdm｣: Compiled successfully.
15 01 2020 18:28:13.799:INFO [karma-server]: Karma v4.4.1 server started at http://0.0.0.0:9876/
15 01 2020 18:28:13.813:INFO [launcher]: Launching browsers Chrome with concurrency unlimited
15 01 2020 18:28:13.820:INFO [launcher]: Starting browser Chrome
15 01 2020 18:28:17.075:INFO [Chrome 79.0.3945 (Windows 10.0.0)]: Connected on socket PUKPz4iBuFzeVNSsAAAA with id 91716917
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
        test: /\.spec.js$/i,
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

* 添加一个优先执行的编译 `.spec.js` 文件的 `rules`，`loader` 使用 `istanbul-instrumenter-loader` 并开启 `esModules` 模式

### karma.conf.js

```js
module.exports = function(config) {
  config.set({

    // ...

    coverageIstanbulReporter: {
      reports: [ 'html', 'text' ],
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

再次执行单元测试，我们会看到测试覆盖率的相关信息

```txt
----------------|----------|----------|----------|----------|-------------------|
File            |  % Stmts | % Branch |  % Funcs |  % Lines | Uncovered Line #s |
----------------|----------|----------|----------|----------|-------------------|
All files       |      100 |      100 |      100 |      100 |                   |
 Header.spec.js |      100 |      100 |      100 |      100 |                   |
----------------|----------|----------|----------|----------|-------------------|
```

也可以通过生成到 `coverage` 目录下的网页文件，在浏览器中查看

![](./coverage.png)

## 参考资料

* [https://vue-test-utils.vuejs.org/zh/](https://vue-test-utils.vuejs.org/zh/)
* [https://github.com/mattlewis92/karma-coverage-istanbul-reporter](https://github.com/mattlewis92/karma-coverage-istanbul-reporter)

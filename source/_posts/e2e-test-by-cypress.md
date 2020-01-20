---
title: 使用 cypress 做 E2E 测试
tags:
  - e2e test
categories: architect
date: 2020-01-20 17:22:57
---


E2E 测试即 End to End，也就是端到端测试，属于黑盒测试。通过编写测试用例，自动化模拟用户操作，确保应用程序能够如期运行。以 [react-multi-page](https://github.com/cntanglijun/web-building-boilerplates/tree/master/react-multi-page) 模版为例，谈谈如何使用 cypress 做 E2E 测试

<!--more-->

## 技术栈

* cypress[3.8.2]
* eslint-plugin-cypress[2.8.1]

## 如何配置

安装 cypress

```
npm i cypress eslint-plugin-cypress -D
```

设置 npm 脚本命令

```json
{
  "scripts": {
    "test:e2e": "cypress open"
  }
}
```

运行 cypress

```
node_modules/.bin/cypress open
```

![](./1.png)

cypress 启动后，会在根目录看到 `cypress` 目录，里面存放了运行 `cypress` 相关的配置资料，为了分类处理目录结构，可以约定将测试相关的资料统一放在 `test` 目录中。那么在根目录建立 `test/e2e` 目录用于存放 E2E 测试相关资料，并把 `cypress` 目录中的资料转移到 `test/e2e` 目录中

```txt
<root>
  |__ test
    |__ e2e
      |__ fixtures
      |__ integration
      |__ plugins
      |__ support
```

在根目录创建 `cypress.json`，配置相关目录指向 `test/e2e` 文件夹

```json
{
  "baseUrl": "http://localhost:3000/",
  "fixturesFolder": "test/e2e/fixtures",
  "integrationFolder": "test/e2e/integration",
  "pluginsFile": "test/e2e/plugins/index.js",
  "screenshotsFolder": "test/e2e/screenshots",
  "supportFile": "test/e2e/support/index.js",
  "videosFolder": "test/e2e/videos",
  "video": false
}
```

> 其中 `baseUr` 根据实际网站域名端口自行配置，`video` 默认是启用状态，我这里设置关闭即不保存测试录屏文件

## 编写测试用例

现在我们可以来编写一些简单的测试用例，来测试我们的 APP 的运行是否按预期执行

![](./2.png)

假设我们的测试点有：

* 首页包含 `Index` 文字
* 首页包含 `Link To Home` 文字
* 可以点击 `Link To Home` 文字
* 点击 `Link To Home` 文字后进入新页面，新页面 url 中包含 `home` 文字

编写成对应的 E2E 测试用例如下：

```js
// test/e2e/integration/Index.spec.js
describe('The Home Page', function() {
  it('successfully loads', function() {
    cy.visit('/')
    cy.contains('Index')
    cy.contains('Link To Home').click()
    cy.url().should('include', 'home')
  })
})
```

## 运行结果

重新启动 `cypress`，选择 `Index.spec.js`，可以看到完整的测试流程，并显示测试已经通过

![](./3.png)

## 持续集成

上面我们通过 `cypress open` 命令手动测试，但在实际工作中可能需要在持续集成环境中运行 E2E 测试，可以使用 `cypress run` 命令

```json
{
  "scripts": {
    "test:e2e": "npm run serve && cypress run"
  }
}
```

但是很快就发现问题了，执行 `npm run serve` 后终端被服务器进程挂起，无法执行后面的 `cypress run` 命令，于是我引入 [start-server-and-test](https://github.com/bahmutov/start-server-and-test) 来处理 `npm run serve` 的阻塞问题，也可以使用官方文档中的 [wait-on](https://github.com/jeffbski/wait-on)

```json
{
  "scripts": {
    "cypress:open": "cypress open",
    "cypress:run": "cypress run",
    "serve": "node prod.server.js",
    "test:e2e": "start-server-and-test serve http://localhost:3000 cypress:open",
    "test-ci:e2e": "start-server-and-test serve http://localhost:3000  cypress:run"
  }
}
```

现在 `npm run serve` 不会阻塞后面的任务了，终端运行结果如下

```txt
====================================================================================================

  (Run Starting)

  ┌────────────────────────────────────────────────────────────────────────────────────────────────┐
  │ Cypress:    3.8.2                                                                              │
  │ Browser:    Electron 78 (headless)                                                             │
  │ Specs:      1 found (Index.spec.js)                                                            │
  └────────────────────────────────────────────────────────────────────────────────────────────────┘


────────────────────────────────────────────────────────────────────────────────────────────────────

  Running:  Index.spec.js                                                                   (1 of 1)
undefined

  The Home Page
    √ successfully loads (1395ms)
undefined
undefined
  1 passing (2s)
undefined

  (Results)

  ┌────────────────────────────────────────────────────────────────────────────────────────────────┐
  │ Tests:        1                                                                                │
  │ Passing:      1                                                                                │
  │ Failing:      0                                                                                │
  │ Pending:      0                                                                                │
  │ Skipped:      0                                                                                │
  │ Screenshots:  0                                                                                │
  │ Video:        false                                                                            │
  │ Duration:     1 second                                                                         │
  │ Spec Ran:     Index.spec.js                                                                    │
  └────────────────────────────────────────────────────────────────────────────────────────────────┘


====================================================================================================

  (Run Finished)


       Spec                                              Tests  Passing  Failing  Pending  Skipped
  ┌────────────────────────────────────────────────────────────────────────────────────────────────┐
  │ √  Index.spec.js                            00:01        1        1        -        -        - │
  └────────────────────────────────────────────────────────────────────────────────────────────────┘
    √  All specs passed!                        00:01        1        1        -        -        -
```

## 参考资料

* [https://docs.cypress.io/zh-cn/guides/overview/why-cypress.html](https://docs.cypress.io/zh-cn/guides/overview/why-cypress.html)

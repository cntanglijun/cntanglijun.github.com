---
title: vue 与 react 之间的对比
tags:
  - vue
  - react
categories: architect
date: 2021-04-10 19:44:43
---


vue 和 react 是前端主流的两款框架，文本主要来聊聊他们之间的共同点和不同点

<!-- more -->

### 共同点

* 使用 Virtual DOM
* 提供了响应式（Reactive）和组件化（Composable）的视图组件
* 将注意力集中保持在核心库，而将其他功能如路由和全局状态管理交给相关的库

### 不同点

#### 渲染优化

react 组件的状态发生变化时会以该组件为根重新渲染整个组件子树。一般为了避免不必要的子组件的重新渲染，需要使用 `PureComponent` 或者手动实现 `shouldComponentUpdate` 方法

vue 组件的依赖是在渲染过程中自动追踪的，所以系统能精确知晓哪个组件确实需要被重新渲染

vue 相比 react 在渲染优化方面开发者无需有过多的考虑

#### HTML & CSS

react 中一切都是 javascript，HTML 也好、CSS 也好都可以在 javascript 中处理

vue 的整体思想是拥抱经典的 web 技术，并进行相应扩展

#### JSX vs Templates

react 中使用 JSX（一种使用 XML 语法编写 javascript 的语法糖），JSX 的优势如下

* 可以使用完整的 javascript 语言来构建视图页面，例如变量、流程控制、作用域等
* 开发工具对 JSX 的支持较 vue 模版更成熟（例如 linting、类型检查、自动补充等）

vue 默认推荐使用模版（vue 本身提供了渲染函数，甚至支持 JSX），使用 vue 模版的优势如下

* 对于习惯 HTML 的开发者，vue 模版比 JSX 读写更自然。虽然这有主观偏好的因素，但如果这种差异能导致开发效率的提升，那么它就有客观的价值存在
* 基于 HTML 的模版使得将已有的应用逐步迁移到 vue 更加容易
* 对于设计师以及刚入门的开发者能够更容易的理解和参与到项目中
* vue 模版支持第三方的模版预处理器（例如 pug、ejs）

vue 官方认为组件有两类：

* 偏视图表现的（presentational）
* 偏逻辑的（logical）

对于偏视图表现的组件推荐使用模版，对于偏逻辑的组件推荐使用 JSX 或渲染函数，总的来看表现类组件是要多余逻辑类组件的

#### 组件作用域内的 css

react 通过 css-in-js 实现 css 作用域，vue 是通过 style 标签

相比之下 vue 的方式更加自然和灵活

#### 向上扩展

vue 和 react 都提供了强大的路由来应对大型应用。react 有 flux、redux，vue 有 vuex（vue 也可以很容易集成 redux）

vue 的路由库和状态管理库都是由官方维护支持并且与核心库同步更新的。react 则把这些问题交给社区维护，因此创建了一个更分散的生态系统。这也使得 react 的生态系统比 vue 更繁荣

vue 提供了 vue-cli 工具，可以通过交互式的脚手架引导快速构建项目。react 提供了 create-react-app，由于两者设计理念之间的差异而存在一些局限性

* 它不允许在项目生成时进行任何配置，而 vue-cli 运行于可升级的运行时依赖之上，该运行时可以通过插件进行扩展
* 它只提供一个构建单页面应用的默认选项，而 vue 提供了各种用途的模版
* 它不能用用户自建的预设配置构建项目，这对企业环境下预先建立约定是特别有用的

#### 向下扩展

react 学习曲线陡峭，在学习 react 之前需要了解 JSX、ES2015、构建系统。vue 向上扩展好比 react，向下扩展类似 jQuery，只需要引入

```html
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
```

vue 在起步阶段无需学习 JSX、ES2015 和构建系统，所以开发者可以快速上手

#### 原生渲染

react 方面对于原生 app（ios 和 android）可以用 react native。vue 则是和 weex 合作来开发原生 ios 和 android app，单从成熟度来说 react native 要胜过 weex

#### mobx

mobx 在 react 社区很流行，而 vue 实际上也采用了几乎相同的反映系统。react + mobx 也可看作是更繁琐的 vue

#### preact 和其他类 react 库

类 react 库往往尽可能地与 react 共享 api 和生态，因此上述比较对它们同样适用。它们与 react 的不同在于更小的生态，由于无法 100% 兼容 react 生态中的全部，一些工具和辅助库可能无法使用，或多或少会出现兼容问题

### 参考资料

* [https://cn.vuejs.org/v2/guide/comparison.html](https://cn.vuejs.org/v2/guide/comparison.html)

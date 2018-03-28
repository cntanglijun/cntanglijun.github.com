---
title: 使用 Hexo 搭建 github 博客
date: 2015-07-30 19:47:00
categories: hexo
tags: starting
---

Hexo 是一个快速、简洁且高效的博客框架。由台北的 **[Tommy Chen](https://github.com/tommy351 "Tommy Chen")** 创建并维护。

<!--more-->

## 安装 nodejs

hexo 基于 nodejs ，首先我们需要安装 nodejs 。**[官网下载](https://nodejs.org/download/ "官网下载")**

![安装 nodejs ](./img/install-nodejs.jpg "安装 nodejs ")

安装成功，打开 cmd 终端，检测 nodejs

``` bash
node -v
```

![检测 nodejs ](./img/check-nodejs.jpg '检测 nodejs')

**恭喜你，nodejs 安装成功！**

## 安装 hexo-cli

``` bash
npm install -g hexo-cli
```

![安装 hexo-cli](./img/install-hexo-cli.jpg "安装 hexo-cli")

**恭喜你，hexo-cli 安装成功**

## 初始化站点

``` bash
hexo init <folder>
cd <folder>
npm i
```

![初始化站点](./img/init-hexo-site.jpg "初始化站点")

**不错，你的第一个 hexo 站点已经初始化**

## 开启本地服务器

``` bash
hexo serve --port 8888
```

![开启本地服务器](./img/start-serve.jpg "开启本地服务器")

![默认站点](./img/view-hexo-site.jpg "默认站点")

**至此，你的博客搭建完毕**

## 部署到 github

部署之前我们需要安装一个 hexo 插件

``` bash
npm i hexo-deployer-git --save
```

![安装 hexo-deployer-git](./img/install-hexo-deployer-git.jpg "安装 hexo-deployer-git")

修改 `_config` 配置

``` bash
# Deployment
## Docs: http://hexo.io/docs/deployment.html
deploy:
  type: git
  repo:
    github: git@github.com:<name>/<proj>.git,gh-pages
```

打开 package.json 设置部署命令

``` json
"scripts": {
  "deploy": "hexo clean && hexo deploy && rm -rf .deploy_git && hexo clean",
  "serve": "hexo clean && hexo generate && hexo serve"
}
```

执行部署命令

``` bash
npm run deploy
```

![发布网站](./img/deploy-site.jpg "发布网站")

**恭喜你，你已经学会使用 hexo 来搭建 github 博客了**

## 参考资料

*   **[hexo 官方文档](https://hexo.io/zh-cn/ "hexo 官方文档")**
*   **[nodejs](https://nodejs.org/ "nodejs")**
*   **[github pages](https://pages.github.com/ "github pages")**

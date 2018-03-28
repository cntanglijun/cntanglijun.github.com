---
title: 使用 Jekyll 搭建 github 博客
date: 2015-07-14 00:19:00
categories: jekyll
tags: starting
---

[Jekyll](http://jekyllrb.com/ "Jekyll") 是一个简单的博客形态的静态站点生产机器。它有一个模版目录，其中包含原始文本格式的文档，通过 [Markdown](http://daringfireball.net/projects/markdown/ "Markdown") 以及 [Liquid](https://docs.shopify.com/themes/liquid-documentation/basics "Liquid") 转化成一个完整的可发布的静态网站，你可以发布在任何你喜爱的服务器上。Jekyll也可以运行在 [GitHub Page](https://pages.github.com/ "GitHub Page") 上，也就是说，你可以使用 [GitHub](https://github.com/ "GitHub") 的服务来搭建你的项目页面、博客或者网站，而且是完全免费的。

<!--more-->
## Windows 系统中安装 Jekyll，High 起来，yeah!
### 安装 Ruby 和 Ruby DevKit

[下载Ruby2.0.0-p481 x86/x64](http://rubyinstaller.org/downloads/archives "下载Ruby")

安装 Ruby, 勾选 Add Ruby executable to your PATH

![安装Ruby](./img/install_ruby.jpg "安装Ruby")

[下载Ruby DevKit x86/x64](http://rubyinstaller.org/downloads/ "下载Ruby DevKit")

安装 Ruby DevKit

![安装 Ruby DevKit](./img/install_ruby_devkit.jpg "安装 Ruby DevKit")

打开命令行工具 cmd

``` bash
win + R and input cmd
```

进入 RubyDevKit 目录

``` bash
cd c:/RubyDevKit
```

自动检测 Ruby installations 并把它们添加到配置文件

``` bash
ruby dk.rb init
```

安装 DevKit, 绑定到你的 Ruby installation

``` bash
ruby dk.rb install
```

**很好！你已经完成了安装 jekyll 的准备工作。敢不敢继续挑战下一步，安装jekyll? : )**

### 安装 jekyll

确认 gem 正确安装

``` bash
gem -v
```

![确认 gem 正确安装](./img/ensure_gem_installed.jpg "确认 gem 正确安装")

如果正确显示版本号则继续, 否则请重新安装 Ruby

``` bash
gem install jekyll
```

确认 jekyll 正确安装

``` bash
jekyll -v
```

![确认 jekyll 正确安装](./img/ensure_jekyll_installed.jpg "确认 jekyll 正确安装")

**恭喜你！你已经成功安装了 jekyll, 是不是兴奋起来了，我们继续 high!**

### 创建你的 github 帐号

进入 [GitHub] 官网

![注册 github 帐号](./img/sign_up_for_github.jpg "注册 github")

输入你的注册信息并创建 github 帐号 **(注意: 帐号名请使用小写，因为 blog 的用户名将用作二级域名使用，如果存在大写将导致你的 blog 无法打开)**

![创建 github 帐号](./img/create_github_account.jpg "创建 github 帐号")

选择新建仓库

![新建仓库](./img/select_new_repository.jpg "选择创建新仓库")

创建你的仓库 **(注意: 仓库名的命名格式为 username_of_github_account.github.io)**

![创建仓库][create_repository](./img/create_repository.jpg "创建仓库")

**当你按下按钮的那刻起，你的博客托管服务器便成功建立了，是不是热血沸腾了呢？加油，好戏还在后面。**

### 安装 git

[下载 git](http://msysgit.github.io/ "下载 git")

安装 git

![安装 git](./img/install_git.jpg "安装 git")

确认 git 正确安装

``` bash
git --version
```

![确认 git 正确安装](./img/ensure_git_installed.jpg "确认 git 正确安装")

设置 git 用户信息

``` bash
git config --global user.name 'your name'
git config --global user.email 'you email address'
```

查看 git 配置信息

``` bash
git config --list
```

![查看 git 配置信息](./img/check_git_config_list.jpg "查看 git 配置信息")

**能来到这里说明你是个有实力的家伙，不过别得意，后面的任务你能完成吗？**

### 添加 SSH Keys 到 github 帐号

打开你的 git bash 终端, 检查 SSH Keys 是否存在

``` bash
ls -al ~/.ssh
```

![查看 ssh_keys 是否存在](./img/check_ssh_keys_existed.jpg "查看 ssh_keys 是否存在")

如果不存在也没关系，下面我们来创建它

``` bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

![生成一个新的 ssh_key](./img/create_a_new_ssh_key.jpg "生成一个新的 ssh_key")

确认 ssh-agent 开启

``` bash
eval $(ssh-agent -s)
```

![确认 ssh-agent 开启](./img/ensure_ssh_agent_enabled.jpg "确认 ssh-agent 开启")

把 key 添加到 ssh-agent

``` bash
ssh-add ~/.ssh/id_rsa
```

![把 key 添加到 ssh-agent](./img/add_key_to_agent.jpg "把 key 添加到 ssh-agent")

复制 key

``` bash
clip < ~/.ssh/id_rsa.pub
```

![复制 key](./img/clip_key.jpg "复制 key")

进入 github, 选择 settings

![选择 settings](./img/select_settings.jpg "选择 settings")

选择左侧导航 SSH keys

![选择左侧导航 SSH keys](./img/select_ssh_keys.jpg "选择左侧导航 SSH keys")

点击 Add SSH key

![点击 Add SSH key](./img/select_add_ssh_key.jpg "点击 Add SSH key")

添加 SSh key 到 github 帐号

![添加 SSh key 到 github 帐号](./img/add_ssh_key_to_github_account.jpg "添加 SSh key 到 github 帐号")

添加成功

![添加成功](./img/add_ssh_key_success.jpg "添加成功")

测试 git 连接

``` bash
ssh -T git@github.com
```

![测试 git 连接](./img/test_git_connection.jpg "测试 git 连接")

**伸个懒腰，休息一下。轮到我们的 jekyll 上场，好戏才刚刚开始！**

### 创建 jekyll 博客

首先把你的 username_of_github_account.github.io 克隆一份到你的本机上

``` bash
git clone git@github.com:username_of_github_account/username_of_github_account.github.io.gif
```

![克隆一份到本机](./img/clone_github_io_repository.jpg "克隆一份到本机")

初始化一个默认的 jekyll 博客模版

``` bash
jekyll new username_of_github_account.github.io
```

![初始化 jekyll 博客模版](./img/init_default_jekyll_template.jpg "初始化 jekyll 博客模版")

进入该目录

![进入该目录](./img/into_the_repository.jpg "进入该目录")

本地运行 blog **(注意：默认是 4000 端口)**

``` bash
jekyll serve --port 5000
```

![本地运行 blog](./img/run_local_jekyll_serve.jpg "本地运行 blog")

默认样式看起来是这样的

![默认样式看起来是这样的](./img/jekyll_default_theme.jpg "默认样式看起来是这样的")

暂存所有文件到git

``` bash
git add -A
```

![暂存所有文件到 git](./img/add_all_to_git.jpg "暂存所有文件到 git")

提交所有文件到 git

``` bash
git commit -a -m 'update my blog'
```

![提交所有文件到 git](./img/commit_all_files_to_git.jpg "提交所有文件到 git")

提交至 github 仓库

``` bash
git push -u origin master
```

![提交至 github 仓库](./img/push_to_github_repository.jpg "提交至 github 仓库")

**热烈祝贺你！你已经成功创建自己的 github 博客了！你可以通过 username_of_github_account.github.io 访问你的博客了！**

### 参考资料

*   __[Markdown 语法](http://daringfireball.net/projects/markdown/syntax#link/ "Markdown语法")__
*   __[创建 github 网站](https://pages.github.com/ "创建github网站")__
*   __[jekyll 文档](http://jekyllrb.com/docs/home/ "jekyll文档")__
*   __[window 上安装jekyll](http://jekyll-windows.juthilo.com/ "window上安装jekyll")__
*   __[jekyll 主题下载](http://jekyllthemes.org/ "jekyll主题")__
*   __[YAML 标记语言](http://yaml.org/ "YAML标记语言")__
*   __[Liquid 模版语法文档](https://docs.shopify.com/themes/liquid-documentation/basics/ "Liquid模版语法文档")__

---
title: react-native 搭建 android 开发环境之 mac 篇
categories: javascript
tags:
  - react-native
  - android
  - mac
date: 2016-11-02 01:38:52
---

继 [react-native 搭建 android 开发环境之 mac 篇](/2016/10/29/react-native-android-with-windows/) 之后的 react-native 搭建 android 开发环境之 mac 篇。

<!--more-->

# 准备工作

> mac 推荐使用 [homebrew](http://brew.sh/) 工具来安装 nodejs 和 watchman

安装 node

```bash
brew install node
```

安装 watchman

```bash
brew install watchman
```

安装 react-native

```bash
npm install -g react-native-cli
```

下载 android sdk

[https://developer.android.com/studio/index.html](https://developer.android.com/studio/index.html)

# 确认安装信息

打开终端执行 `android`, 确认相关 sdk 安装正确

![ensure_tools.png](./ensure_tools.png)
![ensure_sdk_7.1.1.png](./ensure_sdk_7.1.1.png)
![ensure_api23.png](./ensure_api23.png)

# 确认环境变量

查看 `~/.bash_profile`，确认以下路径设置正确

```java
export ANDROID_HOME=~/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
export PATH=${PATH}:${ANDROID_HOME}/build-tools
```

执行以下命令立即生效

```bash
source ~/.bash_profile
```

# 创建一个安卓虚拟机

打开 avd 管理工具

```bash
android avd
```

![create_emulator.png](./create_emulator.png)

启动虚拟机时可能回到这个错误，这是因为 [HAXM(Intel Hardware Accelerated Execution Manager)](https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager) 没有安装。

![haxm_error_with_emulator](./haxm_error_with_emulator.png)

打开 sdk 管理发现 `haxm 6.0.4` 不支持 mac

![haxm_6.0.4_not_support_for_mac](./haxm_6.0.4_not_support_for_mac.png)

我们去以下地址载 `haxm-macosx_v6_0_3 .zip (6.0.3)` 并安装

[https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager](https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager)

再次启动虚拟机就可以跑起来了。

![start_emulator](./start_emulator.png)

# 测试 react-native

老规矩，初始化一个测试项目

```bash
react-native init AwesomeProject
cd AwesomeProject
react-native run-android
```

![success](success.png)

# 调试 react-native

mac 上调试 app 与 windows 一样，这里不再赘述。请查阅 [调试-react-native](http://f2e-tlj.me/2016/10/29/react-native-android-with-windows/#调试-react-native)

# 打包发布

mac 上打包发布 app 与 windows 一样，这里不再赘述。请查阅 [打包发布](/2016/10/29/react-native-android-with-windows/#打包发布)



# 参考

* [Getting Started](https://facebook.github.io/react-native/docs/getting-started.html)
* [Error in launching avd in mac](http://stackoverflow.com/questions/26714089/error-in-launching-avd-in-mac)
* [Managing avds](https://developer.android.com/studio/run/managing-avds.html)

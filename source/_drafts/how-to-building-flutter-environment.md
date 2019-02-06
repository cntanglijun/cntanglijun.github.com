---
title: 构建 Flutter 开发环境
categories: dart
tags:
  - flutter
  - android
---

本文纪录不使用 Android Studio 构建 Flutter 开发环境，通过命令行工具更灵活。

<!-- more -->

# 获取 Flutter SDK

我们先到 [Flutter 官网](https://flutter.io/docs/get-started/install) 下载对应的 SDK。

* [Windows](https://flutter.io/docs/get-started/install/windows)
* [Mac](https://flutter.io/docs/get-started/install/windows)
* [Linux](https://flutter.io/docs/get-started/install/linux)

# 获取 Android SDK

然后到安卓官网，[下载 Android SDK](https://developer.android.com/studio/)，根据你的系统安装对应的 SDK 包。

> 注意：下载命令行工具

# 设置环境变量

现在我们需要设置环境变量以便在控制台使用 SDK 相关的命令。

## Mac

在 `$HOME/.bash_profile` 中添加以下内容

```
export ANDROID_HOME=~/android
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/tools/bin
export PATH=${PATH}:$HOME/flutter/bin
```

测试 Flutter 可以使用

```
flutter --version

Flutter 1.0.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 5391447fae (10 weeks ago) • 2018-11-29 19:41:26 -0800
Engine • revision 7375a0f414
Tools • Dart 2.1.0 (build 2.1.0-dev.9.4 f9ebf21297)
```

测试 sdkmanager 可以使用

```
sdkmanager --version

26.1.1
```

# 创建模拟器

在开发项目之前我们还需要安装模拟器。

## Android

开发安卓我们需要安装这些模块

* build-tools;28.0.3
* emulator
* platform-tools
* platforms;android-28
* system-images;android-28;default;x86_64

使用 `sdkmanager "<item>"` 安装，安装完毕后我们用以下命令创建一个安卓模拟器

```
avdmanager create avd -n ryuu -k "system-images;android-28;default;x86_64" -d 29
```

查看安卓模拟器是否创建成功

```
flutter emulators

1 available emulator:

ryuu • 4.65in 720p (Galaxy Nexus) • Generic

To run an emulator, run 'flutter emulators --launch <emulator id>'.
To create a new emulator, run 'flutter emulators --create [--name xyz]'.

You can find more information on managing emulators at the links below:
  https://developer.android.com/studio/run/managing-avds
  https://developer.android.com/studio/command-line/avdmanager
```

然后执行下面的命令运行安卓模拟器

```
flutter emulators --launch ryuu
```

模拟器界面如下

![android-emulator](./android-emulator.png)

## IOS

我们先到官网下载 [Xcode](https://developer.apple.com/xcode/download/) 并安装，然后根据 `fluter doctor` 的提示安装相应模块

```
brew update
brew install --HEAD usbmuxd
brew link usbmuxd
brew install --HEAD libimobiledevice
brew install ideviceinstaller
brew install ios-deploy
brew install cocoapods
pod setup
```

模块安装好之后，我们可以用以下命令打开 IOS 模拟器

```
open -a Simulator
```

模拟器界面如下

![ios-emulator](./ios-emulator.png)

# 参考资料

* [https://flutter.io/](https://flutter.io/)

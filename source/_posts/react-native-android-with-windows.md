---
title: react-native 搭建 android 开发环境之 windows 篇
categories: javascript
tags:
  - react-native
  - android
  - windows
date: 2016-10-29 17:20:52
---


Windows 中搭建 react-native 的 android 开发环境可谓一波三折。本文记录下我的踩坑之旅，也为了让他人少走弯路。

<!-- more -->

# 准备工作

安装 nodejs

<https://nodejs.org/en/>

安装 python2

<https://www.python.org/downloads/>

安装 react-native

```bash
npm i -g react-native-cli
```

安装 JDK

[http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

安装 android sdk

> 我建议下载非安装版本 <https://dl.google.com/android/android-sdk_r24.4.1-windows.zip>

其他版本

<https://developer.android.com/studio/index.html#downloads>

# 确认安装信息

![ensure_tools](ensure_tools.png)
![ensure_android7.1.1](ensure_android7.1.1_api25.png)
![ensure_android6.0_api23](ensure_android6.0_api23.png)
![ensure_extras](ensure_extras.png)

# 确认环境变量

![ensure_variable](ensure_variable.png)
![ensure_path](ensure_path.png)

# 创建一个安卓虚拟机

[https://developer.android.com/studio/run/managing-avds.html](https://developer.android.com/studio/run/managing-avds.html)

![create_avd](create_avd.png)

# 测试 react-native

至此准备工作已经就绪，我们迫不及待的想要进入 react-native 的世界探索一番，当然首先我们从 hello world 启程。

```bash
react-native init AwesomeProject
cd AwesomeProject
```

开启 android 虚拟机，虚拟机开启并进入系统后，运行下面的命令

```bash
react-native run-android
```

![success](success.png)

# 调试 react-native

`ctrl` + `m` 打开开发者面板，启用 `Enable Live Reload` 和 `Enable Hot Reloading`

![enable_live_reload_and_hot_reloading](enable_live_reload_and_hot_reloading.png)

还可以启用 chrome 控制台远程调试 JS，启用 `Debug JS Remotely`

![debug_js_remotely](debug_js_remotely.png)
![screenshot](screenshot.png)

# 打包发布

安卓 APP 需要数字签名来作验证。所以我们需要生成一个有签名的 APK。可以使用 `keytool`

```bash
keytool -genkey -v -keystore my-release-key.keystore -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000
```

执行以上命令后会生成 `my-release-key.keystore` 文件，把它放到 `android/app` 目录中

![place_keystore_file](place_keystore_file.png)

创建或编辑 `~/.gradle/gradle.properties` 文件, `*****` 替换成正确的密码

```markdown
MYAPP_RELEASE_STORE_FILE=my-release-key.keystore
MYAPP_RELEASE_KEY_ALIAS=my-key-alias
MYAPP_RELEASE_STORE_PASSWORD=*****
MYAPP_RELEASE_KEY_PASSWORD=*****
```

编辑 `android/app/build.gradle`，添加以下配置

```markdown
...
android {
    ...
    defaultConfig { ... }
    signingConfigs {
        release {
            storeFile file(MYAPP_RELEASE_STORE_FILE)
            storePassword MYAPP_RELEASE_STORE_PASSWORD
            keyAlias MYAPP_RELEASE_KEY_ALIAS
            keyPassword MYAPP_RELEASE_KEY_PASSWORD
        }
    }
    buildTypes {
        release {
            ...
            signingConfig signingConfigs.release
        }
    }
}
...
```

生成发行 APK，进入 android 目录

```bash
./gradlew assembleRelease
```

执行完毕会生成 `android/app/build/outputs/apk/app-release.apk` 文件

![generated_apk](generated_apk.png)

也许有人会问，为什么会生成 2 个 APK 文件，请仔细阅读下面的回答

http://stackoverflow.com/questions/22058210/why-unaligned-apk-is-needed

测试打包后的 APP

```bash
react-native run-android --variant=release
```

![apk_testing](apk_testing.png)
![success](success.png)

测试完毕之后，选择想要发布的平台发布你的 APP 吧。每个平台机制不同，这里就不做介绍了，大家自己去了解即可。

那么我们的 react-native 安卓之旅已经启程了~ 加油吧少年们！最后，祝大家开发愉快 :)

# 参考

* [Getting Started](https://facebook.github.io/react-native/docs/getting-started.html#content)
* [Signed APK Android](https://facebook.github.io/react-native/docs/signed-apk-android.html)
* [Sign Your App](https://developer.android.com/studio/publish/app-signing.html)
* [Failed to find target with hash string 'android-23'](https://github.com/facebook/react-native/issues/5442)
* ['adb' is not recognized as an internal or external command, operable program or batch file](http://stackoverflow.com/questions/20564514/adb-is-not-recognized-as-an-internal-or-external-command-operable-program-or)
* [React Native android build failed](http://stackoverflow.com/questions/32634352/react-native-android-build-failed)
* [get “bash: keytool: command not found.” when Obtaining Google Map Key on linux fedora](http://stackoverflow.com/questions/17043363/i-get-bash-keytool-command-not-found-when-obtaining-google-map-key-on-linux)
* [Manually installing an updated APK fails with “signatures do not match the previously installed version”](http://stackoverflow.com/questions/31489567/manually-installing-an-updated-apk-fails-with-signatures-do-not-match-the-previ)

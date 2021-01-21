# 卒中中心信息采集系统APP端

## 概述		

​	急性缺血性脑卒中是脑动脉闭塞引起部分脑组织梗死的中枢神经系统血管性疾病，具有较高的致残率和致死率，已成为危害人类健康的重大疾病之一。脑卒中发病后脑组织受损程度与缺血时间密切相关，该疾病的救治具有时间依赖性。

​		常规卒中急救流程救治及护理虽然能够达到急救要求，但常规卒中急救及管理存在急救药品和设备准备不充分、任务分配不明确、信息共享时间长、各科室配合度差等问题，常会导致各环节衔接时间延长，增加患者生命健康危险性。因此，优化改进卒中急救流程，提高信息共享速度，对于降低患者死亡率、提高救治效率至关重要。

​		卒中中心信息采集系统作为一种新型医疗服务系统，能够有效弥补常规卒中急救流程的不足和缺陷，通过信息在线共享，提高了信息的全面性与灵活性，可以方便医护人员随时查询工作流程及患者信息，促进各科室快速协调、配合抢救工作，同时，卒中急救流程信息化还可有效缩短候诊、检查等治疗操作时间，提高抢救效率。

## 技术栈

-   Flutter

    [Flutter中文网](https://flutterchina.club/)

-   云开发CloudBase

    [官网](https://cloud.tencent.com/product/tcb)

-   Node.js

    [中文网](http://nodejs.cn/)   

## 软件截图

<center class="half"><img src="https://gitee.com/cc_li/images/raw/master/20210120210915.jpg" width="200"/><img src="https://gitee.com/cc_li/images/raw/master/20210120211148.jpg" width="200"/><img src="https://gitee.com/cc_li/images/raw/master/20210120211146.jpg" width="200"/><img src="https://gitee.com/cc_li/images/raw/master/20210120211152.jpg" width="200"/><img src="https://gitee.com/cc_li/images/raw/master/20210120211153.jpg" width="200"/><img src="https://gitee.com/cc_li/images/raw/master/20210120211149.jpg" width="200"/><img src="https://gitee.com/cc_li/images/raw/master/20210120211147.jpg" width="200"/><img src="https://gitee.com/cc_li/images/raw/master/20210120211150.jpg" width="200"/><img src="https://gitee.com/cc_li/images/raw/master/20210120211151.jpg" width="200"/><img src="https://gitee.com/cc_li/images/raw/master/20210120211145.jpg" width="200"/><img src="https://gitee.com/cc_li/images/raw/master/20210120211144.jpg" width="200"/>



</center>

## 构建

### Android应用

1.  搭建Flutter环境，详情见[官网](https://flutterchina.club/)。

2.  登录CloudBase控制台，获取相关配置。

    -   获取登录凭证

        登录腾讯云CloudBase[控制台](https://cloud.tencent.com/)，进入以下页面，在移动应用安全来源处，点击添加应用，输入应用标识（应用标识必须是 Android 包名或者 iOS BundleID）。

        ![控制台](https://gitee.com/cc_li/images/raw/master/20210120214848.png)

    -   开通OCR识别。

        登录OCR[控制台](https://console.cloud.tencent.com/ocr/overview)，开通相关服务后，点击右上角个人账号下的访问管理，进入以下页面创建密钥。

        ![](https://gitee.com/cc_li/images/raw/master/20210120221052.png)

3.  修改/CYR/lib/project_config.dart

```dart
// 腾讯云OCR相关配置
static const String tencentOCRSeretkey = ""; // 私钥
static const String tencentOCRSeretId = ""; // 私钥ID
// CloudBase相关配置
 static const tcbAndroidAccessKey = ""; // android 登录凭证
 static const tcbAndroidAccessKeyVersion = "1"; // android 登录凭证版本
 static const tcbIOSAccessKey = ""; // IOS 登录凭证
 static const tcbIOSAccessKeyVersion = ""; // IOS 登录凭证版本
 static const tcbEnv = ""; // tcb环境ID
```

4.  创建私钥信息

```shell
keytool -genkey -v -keystore [存贮路径]/[文件名].jks -keyalg RSA -keysize 2048 -validity 10000 -alias [name]
# 输入后，按照提示输入相应的信息。
```

【 参数信息 】

-genkey 生成证书

-v 详细输出

-keystore 密钥库名称

-keyalg 密钥算法名称

-keysize 密钥位大小

-validity 有效天数

-alias 要处理的条目的别名

5.  在项目的android/app目录下新建key目录，将生成的证书（.jks）放入该文件夹。

6.  在android目录下新建文件key.properties

```shell
# 在文件内写入以下信息
storePassword = [store密码(自己设置的)]
keyPassword = [key密码(自己设置的)]
keyAlias = [别名]
storeFile = key/[文件名].jks
```

7.  配置build.gradle。

```shell
# 打开android/app目录下的build.gradle

# 在android{……}前添加以下code
def keyStorePropertieFile = rootProject.file("key.properties")
def keyStoreProperties = new Properties()
keyStoreProperties.load(new FileInputStream(keyStorePropertieFile))

# 在android{……}里面添加以下code
signingConfigs{
        release{
            keyAlias keyStoreProperties["keyAlias"]
            keyPassword keyStoreProperties["keyPassword"]
            storeFile = file(keyStoreProperties["storeFile"])
            storePassword = keyStoreProperties["storePassword"]
        }
    }
  
# 在android{……}里面的buildTypes{……}中修改以下code
release {
		# 将debug改为release
        signingConfig signingConfigs.release
 }
```

8.  构建APK

```shell
flutter build apk
```

### IOS应用

敬请期待！








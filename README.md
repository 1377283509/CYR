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

<img src="https://gitee.com/cc_li/images/raw/master/20210120210915.jpg" style="zoom: 15%;" />
<img src="https://gitee.com/cc_li/images/raw/master/20210120211148.jpg" style="zoom: 15%;" />
<img src="https://gitee.com/cc_li/images/raw/master/20210120211146.jpg" style="zoom: 15%;" />
<img src="https://gitee.com/cc_li/images/raw/master/20210120211152.jpg" style="zoom: 15%;" />
<img src="https://gitee.com/cc_li/images/raw/master/20210120211153.jpg" style="zoom: 15%;" />
<img src="https://gitee.com/cc_li/images/raw/master/20210120211149.jpg" style="zoom: 15%;" />
<img src="https://gitee.com/cc_li/images/raw/master/20210120211147.jpg" style="zoom: 15%;" />
<img src="https://gitee.com/cc_li/images/raw/master/20210120211150.jpg" style="zoom: 15%;" />
<img src="https://gitee.com/cc_li/images/raw/master/20210120211151.jpg" style="zoom: 15%;" />
<img src="https://gitee.com/cc_li/images/raw/master/20210120211145.jpg" style="zoom: 15%;" />
<img src="https://gitee.com/cc_li/images/raw/master/20210120211144.jpg" style="zoom: 15%;"/>

## 构建安装包

### 1. 登录CloudBase控制台，获取相关配置。

-   获取登录凭证

    登录腾讯云CloudBase[控制台](https://cloud.tencent.com/)，进入以下页面，在移动应用安全来源处，点击添加应用，输入应用标识（应用标识必须是 Android 包名或者 iOS BundleID）。

    <img src="https://gitee.com/cc_li/images/raw/master/20210120214848.png" alt="控制台" style="zoom:50%;" />

-   开通OCR识别。

    登录OCR[控制台](https://console.cloud.tencent.com/ocr/overview)，开通相关服务后，点击右上角个人账号下的访问管理，进入以下页面创建密钥。

    <img src="https://gitee.com/cc_li/images/raw/master/20210120221052.png" style="zoom:50%;" />

### 2. 创建私钥信息

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

### 3. Fork仓库

仓库地址：https://github.com/1377283509/CYR   点击右上角的Fork

### 4. 添加相关Secrets。

-   生成access token，步骤如下图

    Settings > Developr Settings > Personal access token > generate new token > 输入note、勾选权限，最后生成就OK了。

    -   <img src="https://gitee.com/cc_li/images/raw/master/20210123213159.png" style="zoom:50%;" />

    -   <img src="https://gitee.com/cc_li/images/raw/master/20210123213200.png" style="zoom:50%;" />

    

    -   <img src="https://gitee.com/cc_li/images/raw/master/20210123213157.png" style="zoom:50%;" />
    -   <img src="https://gitee.com/cc_li/images/raw/master/20210123213158.png" style="zoom:50%;" />

-   添加Secrets

    进入Fork的仓库 > Settings > Secrets > New respository secret

![](https://gitee.com/cc_li/images/raw/master/20210123213156.png)



​	需要添加的Secrets清单：KEY_ALIAS、KEY_PASSWORD、KEYSTORE_PASSWORD、ENCODED_KEYSTORE、APP_CONFIG

```shell
# 值为创建步骤2(创建私钥)时输入的信息。
KEY_ALIAS  # alias
KEY_PASSWORD # password
KEYSTORE_PASSWORD # keystore 的password

# 值需要将生成的.jks文件转换为base64格式的数据
ENCODED_KEYSTORE
# 生成方法如下: 
# openssl base64 -A -in [文件路径]/[文件名].jks # 注意路径

# APP用到的云开发相关配置, 值同样为base64格式的数据
APP_CONFIG
# 生成方法:
# 1. 在项目根目录下创建app_config.json, 具体文件内容如下。
# 2. 将app_config.json转化成base64格式的数据
# openssl base64 -A -in app_config.json  

```

app_config.json中的数据如下：

```json

{
    // 第一步获取的配置
    "tencentOCRSecretKey": "腾讯OCR Secret Key",
    "tencentOCRSecretId": "腾讯OCR Secret Id",
    "tcbAndroidAccessKey": "Android access key",
    "tcbAndroidAccessKeyVersion": "Android access key version",
    "tcbIOSAccessKey": "IOS access key",
    "tcbIOSAccessKeyVersion": "IOS access key version",
    "tcbEnv": "云开发环境"
}
```

添加完成后清单如图下所示

![](https://gitee.com/cc_li/images/raw/master/20210123215705.png)

### 5. 创建Release，启动自动构建Action

步骤如下图:

-   

![](https://gitee.com/cc_li/images/raw/master/20210123220823.png)



-   

![](https://gitee.com/cc_li/images/raw/master/20210123220825.png)

-   

![](https://gitee.com/cc_li/images/raw/master/20210123220824.png)

这边完成后就可以在tags里面查看到APK，目前只支持Android的自动构建。IOS的后面会逐渐更新。




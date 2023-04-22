---
title:  无法通过send_qywx函数发送企业微信消息
date:   2023-03-28 19:50:30 +0800
categories: faq
order: 2
permalink: /faq/wecom-message
---

（文章编辑中）

<b>问题：</b>

&emsp;&emsp;使用Ptrade内置的send_qywx函数向自己的企业微信账号发送消息，Ptrade终端显示“企业微信消息发送成功”，但实际上企业微信收不到消息。

（相关链接：<a href="http://121.41.137.161:9091/hub/help/api#send_qywx" target="_blank">API文档 - send_qywx发送企业微信信息</a>）

<br>
<b>原因</b>：

&emsp;&emsp;阿猪测试了三家券商，都存在前述问题。阿猪推测应该是send_qywx函数已经和现在的企业微信不兼容了。

<br>
<b>解决方法</b>：

<b>一、自己写代码替代send_qywx</b>

1、获取Ptrade服务器的IP地址

&emsp;&emsp;新建一个策略，写入如下代码，记得将Corpid、Secret、Agentid替换成你自己的。

（相关链接：<a href="https://open.work.weixin.qq.com/wwopen/helpguide/detail?t=selfBuildApp" target="_blank">企业自建应用</a>）
```
import requests, json, datetime

def initialize(context): #初始化模块，每次启动策略时触发执行一次
    pass

def before_trading_start(context, data): #每个交易日开盘前触发执行一次
    Content = str(datetime.datetime.now())    # 消息内容，可随意替换
    Status = SendMessage(msg)  #运行SendMessage函数
    print(Status)   #显示SendMessage函数返回的结果

def SendMessage(msg):
    #生成Token
    Corpid = '替换为你的企业ID'
    Secret = '替换为你的自建应用密钥'
    Agentid = '替换为你的自建应用Agentid'
    Url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken"
    Data = {"corpid": Corpid, "corpsecret": Secret}
    r = requests.get(url=Url, params=Data, verify=False)
    #print(r.json())

    if r.json()['errcode'] != 0:
        return False
    else:
        Token = r.json()['access_token']

    Partyid = '1'    #部门id，根据你的实际情况替换
    Subject = '企业自建应用消息测试'    # 消息标题，可随意替换
    
    # 发送消息
    Url = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=%s" % Token
    Data = {"toparty": Partyid, "msgtype": "text", "agentid": Agentid, "text": {"content": Subject + '\n' + msg}, "safe": "0"}
    r = requests.post(url=Url, data=json.dumps(Data), verify=False)
    return r.json()
```
&emsp;&emsp;运行这个策略，Ptrade终端会显示如下报错信息。这表明Ptrade服务器与企业微信服务器的通信正常，但是Ptrade服务器的IP不在企业微信服务器的白名单内，被企业微信拒绝了。记住这个红框内的字符串，它就是Ptrade服务器的IP地址，后边会用到。
<div  align="center"><img src="/assets/posts_img/20230328_01.webp" alt="" width="600" height=auto/></div>
<br>
2、设置可信域名

&emsp;&emsp;在电脑浏览器中登录企业微信的管理后台，依次点击“应用”-你用于发送通知的自建应用，进入自建应用的管理界面。我们的目的是将Ptrade服务器的IP地址添加入“企业可信IP”名单中。

&emsp;&emsp;如果直接点击“企业可信IP”的“配置”，会提示“请先设置可信域名”，所以需要先设置可信域名。（相关阅读：企业内部开发配置域名指引）

&emsp;&emsp;如果你没有自己的域名，可以随便找一个免费的虚拟主机、函数计算应用，一般都会自带二级或多级域名，只要域名没有被企业微信屏蔽就可以用。因为免费服务不稳定，资源有时效性，所以阿猪不打算专门写教程，具体方法请大家自行百度。
<div  align="center"><img src="/assets/posts_img/20230328_02.webp" alt="" width="600" height=auto/></div>
<br>
3、设置可信IP

&emsp;&emsp;可信域名设置成功后，就可以继续设置可信IP了。点击“企业可信IP”中的“配置”，然后将前边得到的Ptrade服务器IP复制进来，再点击“确定”就可以了。

&emsp;&emsp;在阿猪测试的三家券商中，有两家添加可信IP后就可以正常从Ptrade发送企业微信消息了，有一家添加可信IP时提示“IP属于第三方服务商”，无法在自建应用中使用。对于后者，从技术层面讲是可以解决的，但是在操作层面涉及到券商的配合问题，可行性较差。而且我们的主要目的是用策略赚钱，而不是搞技术研究，所以不再深入讨论，感兴趣的读者可以参考企业可信IP配置指引自行研究。
<div  align="center"><img src="/assets/posts_img/20230328_03.webp" alt="" width="600" height=auto/></div>
<br>
4、在策略中加入消息发送模块

&emsp;&emsp;既然Ptrade内置的send_qywx函数已经失效，那我们就得自己写代码来替代。其实前边的代码就是一个完整的示例代码，只要替换成你的id和密钥就可以正常使用。

&emsp;&emsp;读者可以根据自己的需要在适当的时候调用SendMessage函数。例如我们想在下单后向企业微信发送成交结果，只需把成交结果作为参数传递给SendMessage函数就可以了。

<br>
<b>二、使用替代方案</b>

&emsp;&emsp;如果嫌上边的方法麻烦，或者遇到券商的IP无法设为可信IP的情形，可以尝试下边的方法作为替代方案。

<b>1、使用email</b>

（1）使用Ptrade内置的send_email函数

&emsp;&emsp;关于send_email函数的使用方法，读者可以参考API文档中的send_email - 发送邮箱信息。

（2）使用python内置的smtplib等模块

&emsp;&emsp;关于使用python内置模块实现发送email的方法，请读者先自行百度，后续阿猪会考虑在入门教程或者FAQ中专门写一篇文章来介绍。

<b>2、使用企业微信的群机器人</b>

&emsp;&emsp;是的，你没看错，又是通过企业微信。只不过这里不是使用企业自建应用发送消息，而是通过企业微信群的机器人来发送消息，“秘诀”就在于通过群机器人发送消息不受IP限制。

（1）创建一个企业微信群

（2）添加一个群机器人

（3）获取token

（4）在策略中加入消息发送模块


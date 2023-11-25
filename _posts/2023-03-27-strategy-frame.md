---
title:  05、Ptrade策略框架简介
date:   2023-03-27 19:50:30 +0800
categories: tutorial
order: 5
permalink: /tutorial/strategy-frame
---

&emsp;&emsp;初次接触量化交易的朋友，在开始编写自己第一个策略的时候通常会感觉无从下手。而使用过其他量化平台的老手，在使用新平台的时候往往能够很快上手。这主要是因为新手对量化交易系统的策略框架没有概念，而很多量化交易系统的策略框架逻辑往往都是大同小异的。

&emsp;&emsp;以下三点可以帮助新手快速掌握编写Ptrade量化交易策略的原则：

## 一、Ptrade遵循python的语法

&emsp;&emsp;Ptrade的策略是基于python语言的，所以在编写策略时，需要遵循python的语法；遇到报错时，也需要以python的视角去思考分析错误。

&emsp;&emsp;这里假设读者已经掌握了python的基础语法和关于自定义函数的基础知识。

（相关链接：<a href="https://www.runoob.com/python3/python3-basic-syntax.html" target="_blank">python3的基础语法</a>、<a href="https://www.runoob.com/python3/python3-function.html" target="_blank">pyhon3的自定义函数</a>）

## 二、Ptrade有自己的策略框架体系

&emsp;&emsp;Ptrade中有一些保留的自定义函数名称，这些保留自定义函数可以实现不同的触发逻辑。

&emsp;&emsp;在启动策略时，Ptrade会先启动“策略引擎”，然后再由“策略引擎”来调用用户策略文件中的保留自定义函数。“策略引擎”定义了每个保留自定义函数的执行顺序、触发逻辑。通过这些保留自定义函数与其他API函数的巧妙组合，可以实现各种简单或者复杂的量化交易策略。

&emsp;&emsp;如果你是python初学者的话，我建议你先暂停继续学习Ptrade，花一些时间了解一下python跨文件调用函数的实现方法。这会帮助你更好的了解Ptrade、python是怎么工作的，进而有能力驾驭更复杂的量化交易策略。（相关链接：<a href="https://www.baidu.com/s?ie=UTF-8&wd=python%20%E8%B7%A8%E6%96%87%E4%BB%B6%E8%B0%83%E7%94%A8%E5%87%BD%E6%95%B0" target="_blank">百度-python 跨文件调用函数</a>）


&emsp;&emsp;下边的图表展示了Ptrade的所有保留自定义函数以及它们的触发逻辑。（相关链接：<a href="http://121.41.137.161:9091/hub/help/api#业务流程框架" target="_blank">API文档-业务流程框架</a>）
<div  align="center"><img src="/assets/posts_img/20230327_01.webp" alt="" width="800" height=auto/></div>

### 1、初始化阶段

　　初始化阶段对应API中的initialize()函数，会在策略启动后最先运行，并且只运行一次。初始化阶段的一般作用：

　　(1)为一些基础性的全局变量进行初始化赋值。

　　(2)设置定时任务。（相关链接：<a href="http://121.41.137.161:9091/hub/help/api#定时周期性函数" target="_blank">API文档-定时周期性函数</a>）

　　注意：部分API函数不支持在初始化阶段调用。
<br>

### 2、盘前阶段

　　盘前阶段是指交易日09:15开盘之前的阶段，一般用来更新一些以日为更新频率的全局变量，便于盘中阶段使用。例如我们可以在每个交易日的盘前阶段更新当日的股票池。

　　可以通过before_trading_start()或者run_daily()函数实现在开盘前的固定时间运行。区别对比如下：

<table>
<tbody>
<tr>
<td></td>
<td>before_trading_start()</td>
<td>run_daily()</td>
</tr>

<tr>
<td>首次启动的时间</td>
<td>initialize()函数运行完毕之后立即运行</td>
<td>同“往后启动的时间”</td>
</tr>
<tr>
<td>往后启动的时间</td>
<td>回测模式：08:30<br>交易模式：09:10(以券商的设定为准)</td>
<td>用户自己设定的时间</td>
</tr>
</tbody>
</table>

　　注意：

　　(1)避免在盘前阶段运行耗时过长的代码，以免和盘中阶段相冲突。可考虑放到前一日的盘后阶段。

　　(2)获取行情时，请注意时间上的逻辑关系。例如盘前阶段无法取到当日的开盘价。
<br>

### 3、盘中阶段

　　盘中阶段是指交易日的09:30至15:00，一般用来监控行情报价，并据此产生买卖信号、执行交易。

　　可以通过handle_data()、tick_data()、run_interval()函数来实现盘中定时运行。

区别对比如下：
<table>
<tbody>
<tr>
<td></td>
<td>handle_data()</td>
<td>tick_data()</td>
<td>run_interval()</td>
</tr>

<tr>
<td>支持的模式</td>
<td>回测模式、交易模式</td>
<td>交易模式</td>
<td>交易模式</td>
</tr>

<tr>
<td>支持的周期</td>
<td>1分钟、1天</td>
<td>3秒</td>
<td>自定义（最少3秒）</td>
</tr>

</tbody>
</table>

　　注意：

　　(1)避免在盘中阶段运行耗时过长的代码，以免造成I/O阻塞、影响时效性。可考虑放到盘前阶段或者前一日的盘后阶段。
<br>

### 4、盘后阶段

　　盘后阶段是指交易日15:00收盘之后的阶段，一般用来执行一些盘后复盘类的任务。

　　可以通过after_trading_end()或者run_daily()函数实现在开盘前的固定时间运行。区别对比如下：

<table>
<tbody>
<tr>
<td></td>
<td>after_trading_end()</td>
<td>run_daily()</td>
</tr>

<tr>
<td>启动的时间</td>
<td>15:30(以券商的设定为准)</td>
<td>用户自己设定的时间</td>
</tr>
</tbody>
</table>

　　注意：

　　(1)日频数据的落库时间不固定，一般在15:30-16:00之间可以完成，但也不排除偶尔会有延误。请考虑将启动时间适当的延后，并且增加容错逻辑。

## 三、Ptrade可能存在一些限制和差异

&emsp;&emsp;1、由于Ptrade的策略运行在券商的服务器中，所以出于安全和合规的考虑，券商会限制一些python内置模块和第三方库的使用，并且会限制对外网的访问。视每家券商的配置不同，具体的限制会有差异。

（相关链接：<a href="http://121.41.137.161:9091/hub/help/api#%E6%94%AF%E6%8C%81%E7%9A%84%E4%B8%89%E6%96%B9%E5%BA%93" target="_blank">Ptrade支持的第三方库及其版本</a>）

&emsp;&emsp;2、Ptrade内置的python和部分第三方库的版本较低，在使用时需要注意一下不同版本之间的语法、支持的函数可能会有一些差异。

&emsp;&emsp;经测试，截至2023年3月，Ptrade内置的python版本是3.5.1，而Python官方的最新版本是3.12.0Alpha6。


---
title:  05、Ptrade策略框架简介
date:   2023-03-27 19:50:30 +0800
categories: tutorial
order: 4
permalink: /tutorial/strategy-frame
---

&emsp;&emsp;初次接触量化交易的朋友，在开始编写自己第一个策略的时候通常会感觉无从下手。而使用过其他量化平台的老手，在使用新平台的时候往往能够很快上手。这主要是因为新手对量化交易系统的策略框架没有概念，而很多量化交易系统的策略框架逻辑往往都是大同小异的。

&emsp;&emsp;以下三点可以帮助新手快速掌握编写Ptrade量化交易策略的原则：

&emsp;&emsp;<b>一、Ptrade遵循python的语法</b>

&emsp;&emsp;Ptrade的策略是基于python语言的，所以在编写策略时，需要遵循python的语法；遇到报错时，也需要以python的视角去思考分析错误。

&emsp;&emsp;这里假设读者已经掌握了python的基础语法和关于自定义函数的基础知识。

（相关链接：<a href="https://www.runoob.com/python3/python3-basic-syntax.html" target="_blank">python3的基础语法</a>、<a href="https://www.runoob.com/python3/python3-function.html" target="_blank">pyhon3的自定义函数</a>）

&emsp;&emsp;<b>二、Ptrade有自己的策略框架体系</b>

&emsp;&emsp;Ptrade保留了几个自定义函数，每个保留的自定义函数可以实现一些特定的功能。通过这些自定义函数的巧妙组合，可以实现各种简单或者复杂的量化交易策略。

&emsp;&emsp;下边的图罗列了Ptrade所有保留的自定义函数以及它们的作用。关于它们的用法，请参考API文档以及后续的教程。
（相关链接：<a href="http://121.41.137.161:9091/hub/help/api#%E4%B8%9A%E5%8A%A1%E6%B5%81%E7%A8%8B%E6%A1%86%E6%9E%B6" target="_blank">API文档-业务流程框架</a>）
<div  align="center"><img src="/assets/posts_img/20230327_01.webp" alt="" width="600" height=auto/></div>
<br>
&emsp;&emsp;我们来看一个简单但是结构完整的Ptrade策略：
<div  align="center"><img src="/assets/posts_img/20230327_02.webp" alt="" width="600" height=auto/></div>
<br>
&emsp;&emsp;这个策略的周期级别是每日，回测范围是2023/03/15至2023/03/17。策略的代码包含两个Ptrade保留的自定义函数（initialize、before_trading_start）和一个用户自定义函数func1。它的作用是在每一个交易日的固定时间输出显示一次“今天是一个新的交易日”。

&emsp;&emsp;可能你会说：我能认出来这三个都是自定义函数，但我有两件事情没搞明白：

&emsp;&emsp;（1）自定义函数是怎么被触发的，我怎么没看到调用initialize、before_trading_start这两个自定义函数的代码呢？

&emsp;&emsp;（2）initialize、before_trading_start这两个Ptrade保留的自定义函数是怎么实现在固定的时间触发执行的呢？

&emsp;&emsp;这涉及到Ptrade的工作机制。在启动策略时，Ptrade会先启动“策略引擎”，然后再由“策略引擎”来调用我们策略文件中的自定义函数。每个Ptrade保留的自定义函数有什么功能、它们的执行顺序和执行时间是什么，都是在“策略引擎”中定义的。

&emsp;&emsp;如果你是python初学者的话，我建议你先暂停继续学习Ptrade，花点时间了解一下python跨文件调用函数的实现方法。这会帮助你更好的了解Ptrade、python是怎么工作的，进而有能力驾驭更复杂的量化交易策略。

（相关链接：<a href="https://www.baidu.com/s?ie=UTF-8&wd=python%20%E8%B7%A8%E6%96%87%E4%BB%B6%E8%B0%83%E7%94%A8%E5%87%BD%E6%95%B0" target="_blank">百度-python 跨文件调用函数</a>）

&emsp;&emsp;<b>三、Ptrade可能存在一些限制和差异</b>

&emsp;&emsp;1、由于Ptrade的策略运行在券商的服务器中，所以出于安全和合规的考虑，券商会限制一些python内置模块和第三方库的使用，并且会限制对外网的访问。视每家券商的配置不同，具体的限制会有差异。

（相关链接：<a href="http://121.41.137.161:9091/hub/help/api#%E6%94%AF%E6%8C%81%E7%9A%84%E4%B8%89%E6%96%B9%E5%BA%93" target="_blank">Ptrade支持的第三方库及其版本</a>）

&emsp;&emsp;2、Ptrade内置的python和部分第三方库的版本较低，在使用时需要注意一下不同版本之间的语法、支持的函数可能会有一些差异。

&emsp;&emsp;经测试，截至2023年3月，Ptrade内置的python版本是3.5.1，而官方的最新版本是3.12.0Alpha6。


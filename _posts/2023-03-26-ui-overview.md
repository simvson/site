---
title:  04、客户端界面综览
date:   2023-03-26 19:50:30 +0800
categories: tutorial
order: 4
permalink: /tutorial/ui-overview
---

&emsp;&emsp;Ptrade客户端包含行情、交易、工具、量化、日内五个功能模块。

<b>一、量化模块</b>

&emsp;&emsp;本教程主要介绍量化模块的使用，它包含研究、回测、交易、帮助四个子模块。

<b>1、研究模块</b>

&emsp;&emsp;研究模块有两个子模块，一个是文件管理，一个是Jupyter。

（1）Jupyter

&emsp;&emsp;Jupyter是一个流行的交互式笔记本，用户可以直观的看到代码的运行结果，包括变量的计算结果、生成的图形等等。Ptrade客户端中集成了Jupyter的一些基本功能，方便用户进行策略研究和代码调试。
<div  align="center"><img src="/assets/posts_img/20230326_01.webp" alt="" width="600" height=auto/></div>
<br>
（2）文件管理模块

&emsp;&emsp;文件管理模块允许用户在服务器端创建、编辑、管理自己的文件。

&emsp;&emsp;该模块极大的提高了Ptrade的灵活性，例如：用户可以将数据提前保存到研究目录下，回测时直接从研究目录中读取，可以极大的提高回测速度；用户可以将研究目录作为“中转站”，实现跨策略交互数据；用户可以编写脚本定期将外网数据保存到本地，然后通过定时上传功能上传到服务器，间接实现Ptrade服务器与外网间的数据交互自动化。更多的妙用等待你来发现。
<div  align="center"><img src="/assets/posts_img/20230326_02.webp" alt="" width="600" height=auto/></div>
<br>
<b>2、回测模块</b>

&emsp;&emsp;回测模块主要用于策略的代码调试和回测。用户可以根据回测结果对策略进行分析和调整。
<div  align="center"><img src="/assets/posts_img/20230326_03.webp" alt="" width="600" height=auto/></div>
<br>
<b>3、交易模块</b>

&emsp;&emsp;如果你对策略在回测模式下的运行结果感到满意，那么可以考虑在交易模式下运行该策略。交易模式下运行的策略将会产生真实的交易。

&emsp;&emsp;交易模块支持同时运行多个策略。
<div  align="center"><img src="/assets/posts_img/20230326_04.webp" alt="" width="600" height=auto/></div>
<br>
<b>4、帮助</b>

&emsp;&emsp;这里可以查看完整的API文档。
<div  align="center"><img src="/assets/posts_img/20230326_05.webp" alt="" width="600" height=auto/></div>
<br>
<b>二、其他模块</b>

&emsp;&emsp;除了主打的量化功能，Ptrade还提供行情浏览、手工交易等功能。由于这些不是本教程的侧重点，所以后续不再过多介绍，感兴趣的读者可以自行研究。

<b>1、行情模块</b>

&emsp;&emsp;用户可以在这里浏览股票的分时图、K线图、F10信息等，可以进行简单的自选股管理。
<div  align="center"><img src="/assets/posts_img/20230326_06.webp" alt="" width="600" height=auto/></div>
<br>
<b>2、交易模块</b>

&emsp;&emsp;用户可以在这里进行手工下单、查看持仓信息、资金信息、委托信息、成交记录等。
<div  align="center"><img src="/assets/posts_img/20230326_07.webp" alt="" width="600" height=auto/></div>
<br>
<b>3、工具模块</b>

&emsp;&emsp;这里集成了一些主流的手工交易工具，例如网格交易、算法交易等等。
<div  align="center"><img src="/assets/posts_img/20230326_08.webp" alt="" width="600" height=auto/></div>
<br>
<b>4、日内模块</b>

&emsp;&emsp;这里提供了几种快速手工下单的工具。
<div  align="center"><img src="/assets/posts_img/20230326_09.webp" alt="" width="600" height=auto/></div>

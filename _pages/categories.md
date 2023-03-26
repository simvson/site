---
title: 分类
layout: base
permalink: /categories/
---

## {{ page.title }}
<ul>
{% for category in site.categories %}
    <li><a href="{{ site.baseurl }}/categories/{{ category[0] }}">{{ category[0] }}</a></li>
{% endfor %}
</ul>

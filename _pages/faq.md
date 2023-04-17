---
title: 常见问题
permalink: /faq/
---
### 常见问题(更新中)
{% if site.categories.faq %}
  {% assign sorted_posts = site.categories.faq | sort: 'order' %}
  {% for post in sorted_posts %}
<h4><a href="{{ post.url }}">{{ post.title }}</a></h4>
<!--  <p>{{ post.excerpt }}</p>-->
  {% endfor %}
{% endif %}

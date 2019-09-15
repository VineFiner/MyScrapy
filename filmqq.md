# 抓取腾讯视频

电影列表

https://v.qq.com/x/list/movie?&offset=0

# 一、新建项目

```
➜  MyScrapy git:(master) scrapy startproject filmqq
New Scrapy project 'filmqq', using template directory '/usr/local/lib/python3.7/site-packages/scrapy/templates/project', created in:
    /Users/mac/Desktop/MyScrapy/filmqq

You can start your first spider with:
    cd filmqq
    scrapy genspider example example.com
```

- 创建爬虫

```
➜  MyScrapy git:(master) ✗ cd filmqq 
➜  filmqq git:(master) ✗ scrapy genspider filmqq_spider v.qq.com
```

- 设置爬虫名，和入口 url

```
filmqq git:(master) ✗ vim filmqq/spiders/filmqq_spider.py
```
内容如下

```
# -*- coding: utf-8 -*-
import scrapy


class FilmqqSpiderSpider(scrapy.Spider):
    # 这里是爬虫名，不能和项目名重名,可以和 文件名不同
    name = 'mefilmqq_spider'
    # 允许的域名
    allowed_domains = ['v.qq.com']
     # 入口url
    start_urls = ['https://v.qq.com/x/list/movie?&offset=0']

    # 解析规则
    # 默认解析方法
    def parse(self, response):
        # pass
        print(response.text)

```

- 运行爬虫，查看结果

```
➜  filmqq git:(master) ✗ scrapy crawl mefilmqq_spider
```

> 这里 `mefilmqq_spider` 和爬虫名一致

> 如果运行报错，根据报错，进行设置 
> ```
> ➜  filmqq git:(master) ✗ vim filmqq/settings.py
> ```
> 修改 `USER_AGEN`
>


# 明确目标

### 1、分析网站，明确所需信息

- 编写 `items` 文件

```
➜  filmqq git:(master) ✗ vim filmqq/items.py
```

```
# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class FilmqqItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    # 名称
    movie_name = scrapy.Field()
    # 描述
    describe = scrapy.Field()
```
# 制作爬虫

- 解析文件，修改  `filmqq_spider.py` 文件

```
➜  filmqq git:(master) ✗ vim filmqq/spiders/filmqq_spider.py
```

- 进行解析

```
# -*- coding: utf-8 -*-
import scrapy


class FilmqqSpiderSpider(scrapy.Spider):
    # 这里是爬虫名，不能和项目名重名,可以和 文件名不同
    name = 'mefilmqq_spider'
    # 允许的域名
    allowed_domains = ['v.qq.com']
     # 入口url
    start_urls = ['https://v.qq.com/x/list/movie?&offset=0']

    # 解析规则
    # 默认解析方法
    def parse(self, response):
        # pass
        print(response.text)
```

```

```
# 存储内容

# 我们要抓取的网站

https://movie.douban.com/top250

# 第一步、新建项目
```
$ scrapy startproject douban

New Scrapy project 'douban', using template directory 'c:\\users\\sun94\\appdata\\local\\programs\\python\\python36\\lib\\site-packages\\scrapy\\templates\\project', created in:
    C:\Users\sun94\Desktop\douban\douban

You can start your first spider with:
    cd douban
    scrapy genspider example example.com

$ cd novel
$ scrapy genspider novel_spider movie.douban.com

```
# 第二步、明确目标

- items编写

```
 	# 序号
    serial_number = scrapy.Field()
    # 电影的名称
    movie_name = scrapy.Field()
    # 电影的介绍
    introduce = scrapy.Field()
    # 星级
    star = scrapy.Field()
    # 电影的评论数
    evaluate = scrapy.Field()
    # 电影的描述
    describe = scrapy.Field()
	
```

# 第三步、爬虫文件的编写

- 入口url填写

```
    # 入口url
    start_urls = ['https://movie.douban.com/top250']
```
- 导入 item

- ```
  # -*- coding: utf-8 -*-
  import scrapy
  from douban.items import DoubanItem
  ```

  

- spider 解析

  ```
  import scrapy
  from douban.items import DoubanItem
  
  class DoubanSpiderSpider(scrapy.Spider):
      # 这里是爬虫名
      name = 'douban_spider'
      # 允许的域名
      allowed_domains = ['movie.douban.com']
      # 入口url
      start_urls = ['https://movie.douban.com/top250']
      
      # 解析规则
      # 默认解析方法
      def parse(self, response):
          # 循环电影的条目
          movie_list = response.xpath("//div[@class='article']//ol[@class='grid_view']//li")
          for i_item in movie_list:
              # 导入item文件
              douban_item = DoubanItem()
              # 详细的xpath、进行数据解析
              douban_item['movie_name'] = i_item.xpath(".//div[@class='info']/div[@class='hd']/a/span[1]/text()").extract_first()
              content = i_item.xpath(".//div[@class='info']//div[@class='bd']/p[1]/text()").extract()
              # 多行数据解析
              for i_content in content:
                  content_s = "".join(i_content.split())
                  douban_item['introduce'] = content_s
              douban_item['star'] = i_item.xpath(".//span[@class='rating_num']/text()").extract_first()
              douban_item['evaluate'] = i_item.xpath(".//div[@class='star']//span[4]/text()").extract_first()
              douban_item['describe'] = i_item.xpath(".//p[@class='quote']//span/text()").extract_first()
              douban_item['serial_number'] = i_item.xpath(".//div[@class='item']//em//text()").extract_first()
              # 需要将数据yield到piplines里面
              # 第一页数据
              yield douban_item
          # 解析下一页规则、取后一页的xpath、这里是使用根节点进行解析的
          next_link = response.xpath("//span[@class='next']/link/@href").extract()
          if next_link:
              next_link = next_link[0]
              yield scrapy.Request("https://movie.douban.com/top250"+next_link, callback=self.parse)
  ```

  

# 存储内容

### 本地 json 保存

```
scrapy crawl filmqq_spider -o test.json
```

### 本地 csv 保存

```
scrapy crawl filmqq_spider -o test.csv
```

### 保存到数据库

1、`settings.py` 文件进行配置

- 配置数据库

```
mongo_host = '127.0.0.1'
mongo_port = 27017
mongo_db_name = 'douban'
mongo_db_collection = 'douban_movie'
```
- 开启 pipline

```
# Configure item pipelines
# See https://doc.scrapy.org/en/latest/topics/item-pipeline.html
ITEM_PIPELINES = {
   'douban.pipelines.DoubanPipeline': 300,
}
```

2、`pipelines.py` 文件进行编写

```
# -*- coding: utf-8 -*-
import pymongo
from douban.settings import mongo_host,mongo_port,mongo_db_name,mongo_db_collection
# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html


class DoubanPipeline(object):
    def __init__(self):
        host = mongo_host
        port = mongo_port
        dbname = mongo_db_name
        sheetname = mongo_db_collection
        client = pymongo.MongoClient(host=host,port=port)
        mydb = client[dbname]
        self.post = mydb[sheetname]

    def process_item(self, item, spider):
        data = dict(item)
        self.post.insert(data)
        return item
```
>  安装 `pymongo`
```
pip3 install pymongo
```
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
- spider 解析


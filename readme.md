# 我们要抓取的网站

https://m.sklhjx.com/skxs/124707/30427655.html

# 第一步、新建项目
$ scrapy startproject novel
```
New Scrapy project 'novel', using template directory 'c:\\users\\sun94\\appdata\\local\\programs\\python\\python36\\lib\\site-packages\\scrapy\\templates\\project', created in:
    C:\Users\sun94\Desktop\novel\novel

You can start your first spider with:
    cd novel
    scrapy genspider example example.com
```
$ cd novel
$ scrapy genspider novel_spider m.sklhjx.com

# 第二步、明确目标

- items编写

```
    # 书名
    book_name = scrapy.Field()
    # 章节名
    chapter_name = scrapy.Field()
    # 章节内容
    chapter_content = scrapy.Field()
	
```

# 第三步、爬虫文件的编写

- 入口url填写

- spider 解析


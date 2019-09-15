# -*- coding: utf-8 -*-
import scrapy
from filmqq.items import FilmqqItem

class FilmqqSpiderSpider(scrapy.Spider):
    # 这里是爬虫名，不能和项目名重名,可以和 文件名不同
    name = 'filmqq_spider'
    # 允许的域名
    allowed_domains = ['v.qq.com']
     # 入口url
    start_urls = ['https://v.qq.com/x/list/movie?&offset=0']

    # 解析规则
    # 默认解析方法
    def parse(self, response):
        # 1、这里进行解析列表内容
        video_list = response.xpath("//li[@class='list_item']")
        # 循环电影条目
        for node in video_list:
            # 导入 item文件
            item = FilmqqItem()
            # 写详细的xpath，进行数据解析
            name = node.xpath(".//strong[@class='figure_title']/a/text()").extract()[0]
            score_text = node.xpath(".//div[@class='figure_score']//em/text()").extract()
            score = ''.join(score_text)
            # 数据的处理
            if len(node.xpath(".//span[@class ='figure_info']/text()")):
                short_desc = node.xpath(".//span[@class ='figure_info']/text()").extract()[0]
            else:
                short_desc = ''
            stars_text = node.xpath(".//div[@class='figure_desc']/a/text()").extract()
            stars = ','.join(stars_text)
            hot = node.xpath(".//span[@class='num']/text()").extract()[0]
            play_url = node.xpath(".//a/@href").extract()[0]
            img = node.xpath(".//img/@r-lazyload").extract()[0]
            item['name'] = name
            item['short_desc'] = short_desc
            item['score'] = score
            item['stars'] = stars
            item['hot'] = hot
            item['play_url'] = play_url
            item['img'] = img
            # print(item)
            # yield 到 pipline
            # yield item
            request = scrapy.Request(url=play_url, callback=self.get_detail)
            request.meta['item'] = item
            yield request
            
        # 2、这里是for 循环外面,获取下一页数据内容信息
        # 解析下一页规则
        next_link = response.xpath("//div[@class='mod_pages']/a[@class='page_next']/@href").extract()
        if next_link:
            next_link = next_link[0]
            # 这里有一个回调函数，形成循环，callback=self.parse
            yield scrapy.Request("https://v.qq.com/x/list/movie"+next_link,callback=self.parse)
    # 解析函数结束

    # 获取详情，这里额外写函数进行解析
    def get_detail(self, response):
        item = response.meta['item']
        alias_text = response.xpath("//h1/span/text()")
        if len(alias_text) == 1:
            alias = alias_text.extract()[0]
        else:
            alias = ''

        description = response.xpath("//p[@class='summary']/text()").extract()[0]

        tags_text = response.xpath("//div[@class='video_tags _video_tags']/a/text()").extract()
        if len(tags_text):
            tags = ','.join(tags_text)
        else:
            tags = ''

        play_time = response.xpath("//div[@class='figure_count']/span[@class='num']/text()").extract_first()
        director_list = response.xpath("//div[@class='director']/a/node()").extract()
        stars_list = [x for x in item['stars'].split(',')]
        director_list = [item for item in director_list if item not in stars_list]
        director = ','.join(director_list)

        item['director'] = director
        item['alias'] = alias
        item['tags'] = tags
        item['description'] = description
        item['play_time'] = play_time
        yield item

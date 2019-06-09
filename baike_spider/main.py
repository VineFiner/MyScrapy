#!/usr/bin/env python3
#coding=utf-8

from baike_spider import url_manager
from baike_spider import html_downloader
from baike_spider import html_parser
from baike_spider import html_outputer

class SpiderMain(object):
    def __init__(self):
        # URL 管理器
        self.urls = url_manager.UrlManager()
        # URL 下载器
        self.downloader = html_downloader.HtmlDownloader()
        # URL 解析器
        self.parser = html_parser.HtmlParser()
        # HTML 输出器
        self.outputer = html_outputer.HtmlOutputer()
    # 爬虫调度程序
    def craw(self, root_url):
        count = 1
        self.urls.add_new_url(root_url)
        while self.urls.has_new_url():
            try:
                new_url = self.urls.get_new_url()
                print("craw %d : %s" %(count, new_url))
                html_cont = self.downloader.download(new_url)
                new_urls, new_data = self.parser.paser(new_url, html_cont)
                self.urls.add_new_urls(new_urls)
                self.outputer.collect_data(new_data)

                if count == 1000:
                    break
                count = count + 1
            except:
                print('craw failed')
        self.outputer.output_html()


if __name__ == '__main__':
    root_url = "https://baike.baidu.com/item/Python"
    obj_spider = SpiderMain()
    obj_spider.craw(root_url)
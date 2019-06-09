import Foundation

print("Hello, world!")

class SpiderMain: NSObject {
    // URL 管理器
    let urlManager = UrlManager()
    // URL 下载器
    let downloader = HtmlDownLoad()
    // URL 解析器
    let parser = HtmlParser()
    // HTML 输出器
    let outputer = HtmlOutputer()
    
    // 爬虫调度程序
    func craw(rootUrl: String) {
        var count = 0
        // 添加初始化链接
        self.urlManager.add_new_url(urlString: rootUrl)
        
        while self.urlManager.has_new_url() {
            // 获取链接
            let new_url = self.urlManager.get_new_url()
            // 下载内容
            if let html_content = self.downloader.download(new_url) {
                // 解析内容
                let soupInfo = self.parser.paser(new_url, htmlContent: html_content)
                // 添加链接
                self.urlManager.add_new_urls(soupInfo.newUrl)
                // 添加内容
                self.outputer.collect_data(soupInfo.newData)
            }

            //
            if count > 3 {
                break
            }
            count = count + 1
        }
        // 输出
        self.outputer.output_html()
    }
    
}
// 第一章信息
let rootUrl = "https://www.52bqg.com/book_111399/36221942.html"
let spider = SpiderMain()
spider.craw(rootUrl: rootUrl)

print("end spider")

extension SpiderMain {
    // 获取书籍信息
    func fetchBookInfo(_ urlString: String) {
        if let htmlContent = downloader.download(urlString) {
            self.parser.paserBookInfo(urlString, htmlContent: htmlContent)
        } else {
            print("download error")
        }
    }
}

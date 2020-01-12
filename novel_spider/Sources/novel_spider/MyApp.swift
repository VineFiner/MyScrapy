//
//  MyApp.swift
//  SwiftSoup
//
//  Created by Finer  Vine on 2020/1/12.
//

import Foundation

struct MyApp {
    // URL 管理器
    let urlManager = UrlManager()
    // URL 下载器
    let downloader = HtmlDownLoad()
    // URL 解析器
    let parser = HtmlParser()
    // HTML 输出器
    var outputer = HtmlOutputer()
    
    mutating func run(bookId: String) {
        let rootUrl = "https://www.52bqg.com/book_\(bookId)"
        // 获取书籍信息
        guard var bookInfo = fetchBookInfo(rootUrl) else { return }
        // 下载章节信息
        let arr = bookInfo.chapters.map { (chapter) -> BookChapter in
            let temp = fetchChapterInfo(chapter: chapter, urlString: chapter.linkUrl)
            outputer.collect_data(temp)
            return temp
        }
        bookInfo.chapters = arr
        print(bookInfo)
        outputer.output_html()
    }
    
    // 获取书籍信息
    func fetchBookInfo(_ urlString: String) -> BookInfo?{
        if let htmlContent = downloader.download(urlString) {
            return self.parser.paserBookInfo(urlString, htmlContent: htmlContent)
        } else {
            print("download error")
            return nil
        }
    }
    // 获取章节信息
    func fetchChapterInfo(chapter:BookChapter, urlString: String) -> BookChapter{
        var temp = chapter
        if let htmlContent = downloader.download(urlString) {
            print("chapter:\(temp.title)")
            return self.parser.paserChapter(chapter: &temp, htmlContent: htmlContent)
        } else {
            print("download error")
            return temp
        }
    }
}

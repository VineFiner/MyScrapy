//
//  HtmlParser.swift
//  SwiftSoup
//
//  Created by Finer  Vine on 2019/6/9.
//
import SwiftSoup
import Foundation

struct HtmlParser {
//    // 返回所有链接
//    func getNewUrls(_ pageUrl: String, document: Element) -> [String] {
//        var newUrls: [String] = []
//        do {
//            let bottem  = try document.select("div[class='bottem']").select("a")
//            for link in bottem {
//                let linkHref: String = try link.attr("href"); // 36221942.html
//                let linkText: String = try link.text();
//                if linkText == "下一章" {
//                    let newFullUrl = "\(linkHref)"
//                    newUrls.append(newFullUrl)
//                }
//            }
//        } catch {
//            print("error")
//        }
//        return newUrls
//    }
//    // 返回解析内容
//    func getNewData(_ pageUrl: String, document: Element) -> [String: String] {
//        // 空字典
//        var res_data: [String: String] = [:]
//        res_data["url"] = pageUrl
//        guard let box_con = try? document.select("div[id='box_con']") else { return res_data }
//        if let content = try? box_con.select("div[id='content']").text() {
//            res_data["content"] = content
//        }
//        if let content = try? box_con.select("div[class='bookname']").select("h1").text() {
//            res_data["bookname"] = content
//        }
//        return res_data
//    }
//    // 单章解析
//    func paser(_ pageUrl: String, htmlContent: String) -> (newUrl: [String], newData: [String: String]){
//        var new_urls = [String]()
//        // 空字典
//        var new_data = [String: String]()
//        
//        if let document = try? SwiftSoup.parse(htmlContent) {
//            new_urls = getNewUrls(pageUrl, document: document)
//            new_data = getNewData(pageUrl, document: document)
//            
//            print("\(new_urls)\n:\(new_data)")
//        }
//        return (new_urls, new_data)
//    }
    /// 章节信息解析
    func paserChapter(chapter: inout BookChapter,htmlContent: String) -> BookChapter {
        guard let document = try? SwiftSoup.parse(htmlContent) else { return chapter }
        guard let box_con = try? document.select("div[id='box_con']") else { return chapter }
         if let content = try? box_con.select("div[id='content']").text() {
            chapter.content = content
         }
         if let chapterName = try? box_con.select("div[class='bookname']").select("h1").text() {
            chapter.title = "《第 \(chapterName) 章》"
         }
        return chapter
    }
    /// 书籍信息解析
    func paserBookInfo(_ pageUrl: String, htmlContent: String) -> BookInfo {
        var bookInfo = BookInfo()
         guard let document = try? SwiftSoup.parse(htmlContent) else { return bookInfo }
         guard let box_con = try? document.select("div[class='box_con']") else { return bookInfo }
         if let info = try? box_con.select("div[id='info']") {
             if let h1 = try? info.select("h1").text() {
                 bookInfo.bookName = h1
             }
         }
         guard let lists = try? box_con.select("div[id='list']").select("a") else { return bookInfo }
         for link in lists {
             if let linkHref = try? link.attr("href"), let linkText = try? link.text(){
                 let bookChapter = BookChapter(title: linkText, linkUrl: "\(pageUrl)/\(linkHref)")
                 bookInfo.chapters.append(bookChapter)
             }
         }
         return bookInfo
    }
}
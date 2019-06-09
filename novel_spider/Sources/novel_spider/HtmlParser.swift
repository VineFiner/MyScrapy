//
//  HtmlParser.swift
//  SwiftSoup
//
//  Created by Finer  Vine on 2019/6/9.
//
import SwiftSoup
import Foundation

struct HtmlParser {
    // 返回所有链接
    func getNewUrls(_ pageUrl: String, document: Element) -> [String] {
        var newUrls: [String] = []
        do {
            let bottem  = try document.select("div[class='bottem']").select("a")
            for link in bottem {
                let linkHref: String = try link.attr("href"); // 36221942.html
                let linkText: String = try link.text();
                if linkText == "下一章" {
                    let newFullUrl = "\(linkHref)"
                    newUrls.append(newFullUrl)
                }
            }
        } catch {
            print("error")
        }
        return newUrls
    }
    // 返回解析内容
    func getNewData(_ pageUrl: String, document: Element) -> [String: String] {
        // 空字典
        var res_data: [String: String] = [:]
        res_data["url"] = pageUrl
        guard let box_con = try? document.select("div[id='box_con']") else { return res_data }
        if let content = try? box_con.select("div[id='content']").text() {
            res_data["content"] = content
        }
        if let content = try? box_con.select("div[class='bookname']").select("h1").text() {
            res_data["bookname"] = content
        }
        return res_data
    }
    // 单章解析
    func paser(_ pageUrl: String, htmlContent: String) -> (newUrl: [String], newData: [String: String]){
        var new_urls = [String]()
        // 空字典
        var new_data = [String: String]()
        
        if let document = try? SwiftSoup.parse(htmlContent) {
            new_urls = getNewUrls(pageUrl, document: document)
            new_data = getNewData(pageUrl, document: document)
            
            print("\(new_urls)\n:\(new_data)")
        }
        return (new_urls, new_data)
    }
    // 书籍信息解析
    func paserBookInfo(_ pageUrl: String, htmlContent: String) {
        
        guard let document = try? SwiftSoup.parse(htmlContent) else { return }
        guard let box_con = try? document.select("div[class='box_con']") else { return }
        guard let lists = try? box_con.select("div[id='list']").select("a") else { return }
        if let link = lists.first() {
            let linkHref: String = try! link.attr("href") // "http://example.com/"
            let linkText: String = try! link.text()// "example""
            
            let linkOuterH: String = try! link.outerHtml(); // "<a href="http://example.com"><b>example</b></a>"
            let linkInnerH: String = try! link.html(); // "<b>example</b>"
            
            print("\nlinkHref:\(linkHref)\nlinkText:\(linkText)\nlinkOuterH:\(linkOuterH)\nlinkInnerH:\(linkInnerH)")
        }
    }
}

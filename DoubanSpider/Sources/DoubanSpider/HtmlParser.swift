//
//  HtmlParser.swift
//  DoubanSpider
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Cocoa
import SwiftSoup

class HtmlParser: NSObject {
    
    func getNewUrl(pageUrl: String, content: String) -> (newUrl: String?, newData: String?) {
        guard let document = try? SwiftSoup.parse(content) else {
            return (nil, nil)
        }
        let newUrl = getNewUrl(soup: document)
        
        let chapterName = getChapterName(soup: document) ?? ""
        
        var newData = "\(chapterName)"

        if let greeting = getNewData(soup: document) {
            let index = greeting.index(of: "\n") ?? greeting.startIndex
            let chapterContent = greeting[index...]
            newData.append(String(chapterContent))
            newData.append("\n")
        }
        debugPrint("chapterName:\(chapterName)")
        return (newUrl, newData)
    }
    func getChapterName(soup: Document) -> String? {
        let mainBody = try? soup.select("div[class='articlename']")
        
        if let first = mainBody?.first() {
            let div = try? first.text()
            let contentStr = div?.components(separatedBy: "[").first?.replacingOccurrences(of: " ", with: "") ?? ""
            return contentStr
        }
        return nil
    }
    func getNewUrl(soup: Document) -> String? {
        let mainBody = try? soup.select("ul[class='page']")
        if let first = mainBody?.first() {
            guard let a: Elements = try? first.select("a") else {
                return nil
            }
            if let href = try? a.array().last?.attr("href") {
                return href
            }
        }
        return nil
    }
    func getNewData(soup: Document) -> String? {
        let mainBody = try? soup.select("div[class='content']")

        if let first = mainBody?.first() {
            let div = try? first.text()
//            debugPrint("divContent:\(div ?? "")")
            let contentArr = div?.components(separatedBy: "[")
            let contentStr = contentArr?.first?.replacingOccurrences(of: " ", with: "\n") ?? ""
//            debugPrint("This is \n content:\(contentStr)")
//            let index = contentStr.index(contentStr.startIndex, offsetBy: 100)
//            return String(contentStr[contentStr.startIndex..<index])
            return contentStr
        }
        return nil
    }
}

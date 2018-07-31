//
//  Spider.swift
//  DoubanSpider
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Cocoa

class Spider: NSObject {
    let urls = URLManger()
    let downloader = Downloader()
    let parser = HtmlParser()
    let outputer = HtmlOutputer()
    
    func craw(starUrl: String) -> Void {
        var count = 1
        self.urls.addNewUrl(url: starUrl)
        
        while self.urls.hasNewUrl() {
            
            guard let newUrl = self.urls.getNewUrl() else {
                break
            }
            print("craw \(count) \(newUrl)")
            guard let htmlContent = self.downloader.downLoad(url: newUrl) else {
                break
            }
            let formatContet = self.parser.getNewUrl(pageUrl: newUrl, content: htmlContent)
            if let fetchUrl = formatContet.0 {
                self.urls.addNewUrl(url: fetchUrl)
            }
            if let fetchData = formatContet.newData {
                self.outputer.collect_data(str: fetchData)
            }
//            if count >= 1 {
//                break
//            }
            count += 1
        }
        self.outputer.output_text()
    }
}

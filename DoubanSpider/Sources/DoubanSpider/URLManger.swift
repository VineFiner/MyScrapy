//
//  URLManger.swift
//  DoubanSpider
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Cocoa

class URLManger: NSObject {
    var freshUrls: [String] = []
    var oldUrls: [String] = []
    
    func addNewUrl(url: String) -> Void {
        if !freshUrls.contains(url) && !oldUrls.contains(url) {
            self.freshUrls.append(url)
        }
    }
    func hasNewUrl() -> Bool {
        var status = false
        if self.freshUrls.count > 0 {
            status = true
        }
        return status
    }
    func getNewUrl() -> String? {
        guard let newUrl = self.freshUrls.first else {
            return nil
        }
        self.oldUrls.append(newUrl)
        self.freshUrls.removeFirst()
        return newUrl
    }
    func addNewUrls(urls: [String]) -> Void {
        for url in urls {
            addNewUrl(url: url)
        }
    }
}

//
//  UrlManager.swift
//  SwiftSoup
//
//  Created by Finer  Vine on 2019/6/9.
//

import Foundation

class UrlManager {
    var new_urls: [String]
    var old_urls: [String]
    
    init() {
        self.new_urls = []
        self.old_urls = []
    }
    
    // 添加新的链接
    func add_new_url(urlString: String) {
        if !new_urls.contains(urlString) && !old_urls.contains(urlString) {
            self.new_urls.append(urlString)
        }
    }
    
    // 添加新的链接
    func add_new_urls(_ urls: [String]) {
        for url in urls {
            add_new_url(urlString: url)
        }
    }
    
    // 是否还有链接
    func has_new_url() -> Bool {
        return !new_urls.isEmpty
    }
    
    // 取出链接
    func get_new_url() -> String {
        guard let new_url = self.new_urls.popLast() else {
            return ""
        }
        self.old_urls.append(new_url)
        return new_url
    }
}

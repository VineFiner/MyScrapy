//
//  Downloader.swift
//  DoubanSpider
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Cocoa

class Downloader: NSObject {
    func downLoad(url: String) -> String? {
        guard let loadUrl = URL(string: url) else {
            return nil
        }
        guard let contentStr = try? String.init(contentsOf: loadUrl) else {
            return nil
        }
        return contentStr
    }
}

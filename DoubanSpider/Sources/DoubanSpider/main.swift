//
//  main.swift
//  DoubanSpider
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

let rootUrl = "https://m.sklhjx.com/skxs/124707/30427655.html"

//let typeId = 9
//let bookId = 9102
//let rootUrl = "https://www.piaotian.com/html/\(typeId)/\(bookId)/"
let spider = Spider()
spider.craw(starUrl: rootUrl)

print("Hello, World!")

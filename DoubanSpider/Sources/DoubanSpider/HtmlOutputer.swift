//
//  HtmlOutputer.swift
//  DoubanSpider
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Cocoa

class HtmlOutputer: NSObject {
    var datas: [String] = []
    var fileName = "novel.txt"
    
    func collect_data(str: String) -> Void {
        datas.append(str)
    }
    
    func output_text() -> Void {
        let path = "/Users/mac/Desktop"
        let filePath = "\(path)/\(fileName)"
        let fm = FileManager.default
        fm.createFile(atPath: filePath, contents: "".data(using: .utf8), attributes: nil)
        
        ///
        let fh = FileHandle.init(forWritingAtPath: filePath)
        for contentStr in datas {
            if let data = contentStr.data(using: .utf8) {
                /// 写入数据
                fh?.write(data)
            }
        }
    }
}

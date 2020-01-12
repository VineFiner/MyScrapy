//
//  HtmlOutputer.swift
//  SwiftSoup
//
//  Created by Finer  Vine on 2019/6/9.
//

import Foundation

struct HtmlOutputer {
    
    var datas: [String] = []
    var fileName = "novel.txt"
    
    mutating func collect_data(_ data: BookChapter) {
        datas.append("\(data.title)")
        if let chapterChotent = data.content {
            datas.append(chapterChotent)
        }
    }
    // 输出
    func output_html() {
        let path = "/Users/finervine/Desktop"
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

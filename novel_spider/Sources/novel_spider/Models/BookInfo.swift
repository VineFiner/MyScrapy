//
//  BookInfo.swift
//  SwiftSoup
//
//  Created by Finer  Vine on 2020/1/12.
//

import Foundation

struct BookInfo: Codable {
    var bookName: String = ""
    var authorName: String = ""
    
    var chapters: [BookChapter] = []
}

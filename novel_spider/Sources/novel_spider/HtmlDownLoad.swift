//
//  HtmlDownLoad.swift
//  SwiftSoup
//
//  Created by Finer  Vine on 2019/6/9.
//

import Foundation

struct HtmlDownLoad {
    func download(_ urlString: String) -> String? {
        
        var html: String?
        
        guard let url = URL(string: urlString) else {
            return html
        }
        // 创建同步请求
        let semaphore = DispatchSemaphore(value: 0)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let gbkEnc = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
                if let decodehtml = String(data: data, encoding: String.Encoding(rawValue: gbkEnc)) {
                    html = decodehtml
                }
            }
            semaphore.signal()
        }
        dataTask.resume()
        // 等待
        semaphore.wait()
        return html
    }
}

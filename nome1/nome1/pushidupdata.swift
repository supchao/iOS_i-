//
//  pushidupdata.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/10.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class pushidupdata: NSObject {
    static var sqli = 0
    static var connect = 0
    static var revalue:Bool = false
    public static var pushid:String = ""
    static func idup(_ phonenum:String)-> Bool{
//        pushidupdata.sqli = 0
//        pushidupdata.connect = 0
//
//        pushidupdata.pushid = UserDefaults.standard.string(forKey: "token")!
//
//        let url = URL(string: "http://220.133.159.171/Ordering/user_update_pushid.php")
//        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
//
//        request.httpBody = "pushId=\(pushidupdata.pushid)&mobile=\(phonenum)".data(using: .utf8)
//        request.httpMethod = "POST"
//
//        //MARK: URLSession 建立
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//
//        //MARK: request
//        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
//            if let data = data {
//                let html = String(data:data,encoding:.utf8)
//                if html! == "1" {
//                    self.sqli = 1
//                    self.revalue = true
//                }else{
//                    self.sqli = 0
//                    self.revalue = false
//                }
//            }
//        })
//
//        dataTask.resume()
//        print("this is ok...")
//        while pushidupdata.sqli == 0, pushidupdata.connect != 1 {
//            sleep(1)
//        }
//        return pushidupdata.revalue
        return true
    }
}

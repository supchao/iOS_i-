//
//  GetUserIdViewController.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/14.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class GetUserIdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    static func getId(_ phnum:String)->[[String:Any]]{
        var sql = 0
        var connect = 0
        var json:[[String:Any]] = [[:]]
        let url = URL(string: "http://220.133.159.171/Ordering/Logincheck6.php")
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        
        request.httpBody = "mobile=\(phnum)".data(using: .utf8)
        request.httpMethod = "POST"
        
        //MARK: URLSession 建立
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        //MARK: request
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                let html = String(data:data,encoding:.utf8)
                if let html = html{
                    let html1 = html.data(using: .utf8)
                    do{sql = 1
                        json  = try JSONSerialization.jsonObject(with: html1!, options: .allowFragments) as! [[String:Any]]
                    }catch{
                        sql = 0
                        print("error")
                    }
                }else{
                    //MARK: 沒東西
                    print("路過")
                }
            }
            connect = 1
        })
        
        dataTask.resume()
        print("this is ok...")
        
        while sql == 0,connect != 1{
            sleep(1)
        }
        return json
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

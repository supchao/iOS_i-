//
//  ChangeEmail.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/3.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class ChangeEmail: UIViewController {
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var upemail: UIButton!
    @IBAction func Subemail(_ sender: Any) {
        
        if email.text != "" {
            let fname = email.text!
            let fnames =  正則運算add(fname)
            if fnames == fname{
//      
            let url = URL(string: "http://220.133.159.171/Ordering/update_email.php")
            var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
            
            request.httpBody = "loginId=\(aid)&email=\(fname)".data(using: .utf8)
            request.httpMethod = "POST"
            
            //MARK: URLSession 建立
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            //MARK: request
            let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data {
                    let html = String(data:data,encoding:.utf8)
                    if html! == "1" {
                        //MARK: 更改成功
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }else{
                        print("sql error")
                    }
                }
            })
            dataTask.resume()
            }
            else{
                error.text = "格式錯誤"
            }
        }
    }
    var emails:String = ""
    var json :[[String:Any]]=[[:]]
    var aid :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        json = PersonView.json
        for i in PersonView.json{
            emails = i["email"] as! String
            aid = i["loginId"] as! String
        }
        email.text = emails
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func 正則運算add(_ txt:String)->String{
        let txt1 = txt
        let pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        
        let regulat = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let results = regulat.matches(in: txt1, options: .reportProgress, range: NSMakeRange(0, txt1.count))
        var res = ""
        for result in results{
            res = res + (txt1 as NSString).substring(with: result.range)
        }
        return res
    }
    @IBAction func goback(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

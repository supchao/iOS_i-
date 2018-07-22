//
//  ForgetPassword.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/2.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class ForgetPassword: UIViewController {

    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var Forgetpwdtxt: UITextField!
    @IBAction func Forgetpwd(_ sender: Any) {
        if Forgetpwdtxt.text != ""{
            let passwd = Forgetpwdtxt.text!
            let passwdrare = 正則運算pass(passwd)
            if passwd == passwdrare{
               let phonenum = UserDefaults.standard.string(forKey: "phonenum")
                //-------------------
                let url = URL(string: "http://220.133.159.171/Ordering/Logincheck5.php")
                var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
                
                request.httpBody = "mobile=\(phonenum)&passwd=\(passwd)".data(using: .utf8)
                request.httpMethod = "POST"
                
                //MARK: URLSession 建立
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                
                //MARK: request
                let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data {
                        let html = String(data:data,encoding:.utf8)
                        if html! == "1" {
                            DispatchQueue.main.async {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier:"mainvcc")
                                self.show(vc!, sender:self)
                            }
                        }else{
                            self.error.text = "密碼有誤 請確認"
                            print("註冊失敗")
                        }
                    }
                })
                dataTask.resume()
                //==================
            }else{
                error.text = "密碼不符合規則"
            }
        }else{
            error.text = "密碼長度不足"
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func 正則運算pass(_ txt:String)->String{
        let txt1 = txt
        let pattern = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(\\S){5,}$"
        let regulat = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let results = regulat.matches(in: txt1, options: .reportProgress, range: NSMakeRange(0, txt1.count))
        var res = ""
        for result in results{
            res = res + (txt1 as NSString).substring(with: result.range)
        }
        return res
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func goback(_ sender: Any) {
        dismiss(animated: false, completion: nil)
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

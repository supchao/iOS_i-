//
//  PasswdLoginView.swift
//  nome1
//
//  Created by huang-guochao on 2018/6/30.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit
import CoreLocation

class PasswdLoginView: UIViewController, CLLocationManagerDelegate {
    
    var userphone:String = ""
    @IBOutlet weak var error: UILabel!
    var sql:Int = 0
    var connect:Bool = false
    @IBOutlet weak var passwd: UITextField!
    @IBAction func ToLogin(_ sender: UIButton) {
        //MARK: 正則運算式 -
        if passwd.text != ""{
            let passwd = self.passwd.text!
            // ------
          
            //---------
            var vcstart:ViewController
            vcstart = (self.presentingViewController as! ViewController)
//            let userphone = vcstart.phoneNumber
//            userphone = UserDefaults.standard.string(forKey: "phonenum")!
            userphone = BeforeLoginRegisterData.phonenum
            let url = URL(string: "http://220.133.159.171/Ordering/Logincheck2.php")
            var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
            request.httpBody = "mobile=\(userphone)&passwd=\(passwd)".data(using: .utf8)
            request.httpMethod = "POST"
            //MARK: URLSession 建立
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            //MARK: request
            let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data {
                    let html = String(data:data,encoding:.utf8)
                    if html! == "1" {
                        self.sql = 1
                        print("true\(self.sql)")
                    }else{
                        self.sql = 0
                     print("false\(self.sql)")
                    }
                }
                self.connect = true
            })
            dataTask.resume()
            while sql == 0 ,connect != true{
                sleep(1)
            }
            let upidupdata:Bool = pushidupdata.idup(userphone)
            if sql == 1 ,upidupdata{
            UserDefaults.standard.set(passwd, forKey: "passwd")
            UserDefaults.standard.set(userphone, forKey: "phonenum")
             
            let json = GetUserIdViewController.getId(userphone)
                print("json:\(json)")
                for i in json{
                    UserKey.loginId = i["loginId"] as! String
                    UserKey.name = i["name"] as! String
                    UserKey.email = i["name"] as! String
                    
                    UserKey.mobil = i["mobile"] as! String
                    UserKey.image = Data(base64Encoded: i["image"] as! String)
                }
                Global.updateLogin()
                
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"winner") as! UITabBarController
                vc.selectedIndex = 0
                self.show(vc, sender:self)
            }else {
                error.text = "輸入密碼錯誤，請重試"
            }

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

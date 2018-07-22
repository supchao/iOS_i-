//
//  ViewController.swift
//  nome1
//
//  Created by huang-guochao on 2018/6/28.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseMessaging


class ViewController: UIViewController {
    var sql:Int = 0
    var phoneNumber:String = ""
    var phoneNumber1:String = ""
    var connect:Bool = false
    @IBOutlet weak var error: UILabel!
    @IBAction func GetChk(_ sender: UIButton) {
        
        if PNum.text != ""{
            phoneNumber1 = PNum.text!
            phoneNumber = PNum.text!
            let phoneN = 正則運算phone(phoneNumber)
            print(phoneN)
            if phoneN == phoneNumber{
               
                let url = URL(string: "http://220.133.159.171/Ordering/Logincheck1.php")
                var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
                print(phoneNumber)
                request.httpBody = "mobile=\(phoneNumber)".data(using: .utf8)
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
                        print("有東西")
                        }else{
                        self.sql = 0
                        print("沒東西")
                        }
                    }
                    self.connect = true
                })
                dataTask.resume()
                while self.sql == 0 ,self.connect != true{
                    sleep(1)
                }
//                 UserDefaults.standard.set(phoneNumber1, forKey: "phonenum")
                BeforeLoginRegisterData.phonenum = phoneNumber1
//                 RegisterData.phonenum = phoneNumber1
                if sql == 0{
                    let str = phoneNumber.index(phoneNumber.startIndex, offsetBy: 0)
                    let stt = phoneNumber.index(phoneNumber.startIndex, offsetBy: 1)
                    let enn = phoneNumber.index(str, offsetBy: 10)
                    let pnumto = String(phoneNumber[stt..<enn])
                    phoneNumber = "+886\(pnumto)"
                     //MARK: 使用者 沒有創建過 -
                    PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        // Sign in using the verificationID and the code sent to the user
                        // User ID
                        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                       
                        let vc = self.storyboard?.instantiateViewController(withIdentifier:"CheckVc")
                        self.show(vc!, sender:self)
                    }
                }else if sql == 1 {
                    //MARK: 使用者有創建過 -
                    let vc = self.storyboard?.instantiateViewController(withIdentifier:"passlogin")
                    self.show(vc!, sender:self)
                }
            }
            else if phoneN != phoneNumber{
                error.text = "手機號碼似乎不對喔...請檢查看看"
            }
        }else{
            error.text = "手機號碼似乎不對喔...請檢查看看"
        }  
    }
    

    func 正則運算phone(_ txt:String)->String{
        let txt1 = txt
        let pattern = "^09[0-9]{8}$"
        let regulat = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let results = regulat.matches(in: txt1, options: .reportProgress, range: NSMakeRange(0, txt1.count))
        var res = ""
        for result in results{
            res = res + (txt1 as NSString).substring(with: result.range)
        }
        return res
    }
    @IBAction func GoBack(_ sender: Any) {
//        let vc = self.presentingViewController
//        self.dismiss(animated: false, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBOutlet weak var PNum: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        PNum.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
}


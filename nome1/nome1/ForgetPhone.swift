//
//  ForgetPhone.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/2.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseMessaging

class ForgetPhone: UIViewController {
    var sql:Int = 0
     var connect:Bool = false
    var phoneNumber:String = ""
    var phoneNumber1:String = ""
    @IBOutlet weak var error: UILabel!
    
    @IBOutlet weak var ForgetPnum: UITextField!
    @IBAction func ForgetPN(_ sender: UIButton) {
        if ForgetPnum.text != ""{
            phoneNumber1 = ForgetPnum.text!
            phoneNumber = ForgetPnum.text!
            let phoneN = 正則運算phone(phoneNumber)
            print(phoneN)
            if phoneN == phoneNumber{
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                let savetime = formatter.string(from: Date())

                let url = URL(string: "http://220.133.159.171/Ordering/Logincheck4.php")
                var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
                
                request.httpBody = "mobile=\(phoneNumber1)".data(using: .utf8)
                
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
                        }else{
                            self.sql = 0
                        }
                       
                    }
                    self.connect = true
                })
                dataTask.resume()
                
                while self.sql == 0 ,self.connect != true{
                    sleep(1)
                }
                
                if sql == 1{
                    let str = phoneNumber.index(phoneNumber.startIndex, offsetBy: 0)
                    let stt = phoneNumber.index(phoneNumber.startIndex, offsetBy: 1)
                    let enn = phoneNumber.index(str, offsetBy: 10)
                    let pnumto = String(phoneNumber[stt..<enn])
                    phoneNumber = "+886\(pnumto)"
                    
                    PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                        if let error = error {
                            
                            print(error.localizedDescription)
                            return
                        }
                        // Sign in using the verificationID and the code sent to the user
                        
                        // User ID
                        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier:"ForgetChk")
                        self.show(vc!, sender:self)
                    }
                }else if sql == 0 {
                    error.text = "錯誤，請檢查手機號碼是否正確"
                }

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

//
//  ChangePasswd.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/3.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChangePasswd: UIViewController {
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var chkcode: UITextField!
    var json :[[String:Any]]=[[:]]
   static var aid :String = ""
    static var phone:String = ""
    var verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
  
    @IBAction func chkchkcode(_ sender: UIButton) {
        if chkcode.text != ""{
            sender.isEnabled = false
           let verificationCode = chkcode.text!
            
            Auth.auth().languageCode = "zh";
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID!,
                verificationCode: verificationCode)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    // ...
                    self.error.text = "驗證碼錯誤"
                    print("error.localizedDescription\(error.localizedDescription)")
                    sender.isEnabled = true
                    return
                }
                else{
                    // --------------------
                    let url = URL(string: "http://220.133.159.171/Ordering/update_phone.php")
                    var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
                    
                    print(ChangePasswd.aid)
                    print(ChangePasswd.phone)
                    
                    request.httpBody = "loginId=\(ChangePasswd.aid)&mobile=\(ChangePasswd.phone)".data(using: .utf8)
                    request.httpMethod = "POST"
                    
                    //MARK: URLSession 建立
                    let config = URLSessionConfiguration.default
                    let session = URLSession(configuration: config)
                    
                    //MARK: request
                    let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                        if let data = data {
                            let html = String(data:data,encoding:.utf8)
                            print(html)
                            if html! == "1" {
                                sender.isEnabled = true
                                UserDefaults.standard.set(ChangePasswd.phone, forKey: "phonenum")
                                DispatchQueue.main.async {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier:"winner") as! UITabBarController
                                    vc.selectedIndex = 2
                                    self.show(vc, sender:self)
//                            let story = UIStoryboard(name: "sec", bundle: Bundle(identifier: "program.guochao.nome1"))
//                            let root_vc = story.instantiateInitialViewController() as! UITabBarController
//                            root_vc.selectedIndex = 3
//                            self.dismiss(animated: true, completion: nil)
                                }
                            }else{
                                 sender.isEnabled = true
                                print(" sql error")
                              
                            }
                        }
                    })
                    dataTask.resume()
                    //---------
                    
                    
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "pokerline") as! ChangePasswd
//                    self.dismiss(animated: false, completion: nil)
//                    //                    self.show(vc!, sender:self)
//                    self.personView.present(vc, animated: true, completion: nil)
                }
                // User is signed in
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        json = PersonView.json
        for i in PersonView.json{
            ChangePasswd.aid = i["loginId"] as! String
          
        }
        ChangePasswd.phone = UserDefaults.standard.string(forKey: "changepn")!
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        label.text = "請輸入傳送至\(ChangePasswd.phone)的6位數驗證碼"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

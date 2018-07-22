//
//  Usernameview.swift
//  nome1
//
//  Created by huang-guochao on 2018/6/30.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

import CoreLocation

class Usernameview: UIViewController ,CLLocationManagerDelegate {

    let coll = CLLocationManager()
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBAction func ToUser(_ sender: UIButton) {
//        let phonenum = UserDefaults.standard.string(forKey: "phonenum")
        let phonenum =  BeforeLoginRegisterData.phonenum
        print(phonenum)
//        let passwd = UserDefaults.standard.string(forKey: "passwd")
        let passwd = BeforeLoginRegisterData.passwd
        print(passwd)
//        let email = UserDefaults.standard.string(forKey: "email")
        let email = BeforeLoginRegisterData.email
        if firstname.text != "" ,lastname.text != ""{
            let firstname = self.firstname.text!
            let lastname = self.lastname.text!
           //--------------------------
            let url = URL(string: "http://220.133.159.171/Ordering/Logincheck3.php")
            var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
            
            request.httpBody = "mobile=\(phonenum)&passwd=\(passwd)&email=\(email)&name=\(lastname)&nickname=\(firstname)".data(using: .utf8)
            request.httpMethod = "POST"
            
            //MARK: URLSession 建立
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            //---------------
            
            //---------------
            
            //MARK: request
            let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data {
                    let html = String(data:data,encoding:.utf8)
                    if html! == "1" {
                        print("註冊完成")
                      
                        DispatchQueue.main.async {
                            UserDefaults.standard.set(phonenum, forKey: "phonenum")
                            UserDefaults.standard.set(passwd, forKey: "passwd")
                            UserDefaults.standard.set("", forKey: "email")
                            UserDefaults.standard.synchronize()
                            let upidupdata:Bool = pushidupdata.idup(phonenum)
                            if upidupdata{
                                print("aaa")
                                let togo = self.storyboard?.instantiateViewController(withIdentifier: "winner") as! UITabBarController
                                togo.selectedIndex = 0
                                self.show(togo, sender:self)
                            }
                           
                        }
                    }else{
                       print("註冊失敗")
                       print("error of \(String(describing: error))")
                    }
                }
            })
            dataTask.resume()
            //--------------------------
        }else{
            error.text = "請正確輸入姓氏、名字"
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        coll.requestAlwaysAuthorization()
        coll.delegate = self
        coll.startUpdatingLocation()
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

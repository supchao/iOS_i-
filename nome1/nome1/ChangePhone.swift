//
//  ChangePhone.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/3.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChangePhone: UIViewController {
    @IBOutlet weak var phone: UITextField!
    
    @IBAction func chphonenum(_ sender: UIButton) {
        if phone.text != ""{
            sender.isEnabled = false
            let fname = phone.text!
            let str = fname.index(fname.startIndex, offsetBy: 0)
            let stt = fname.index(fname.startIndex, offsetBy: 1)
            let enn = fname.index(str, offsetBy: 10)
            let pnumto = String(fname[stt..<enn])
            let fname1 = "+886\(pnumto)"
            PhoneAuthProvider.provider().verifyPhoneNumber(fname1, uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    print(error.localizedDescription)
                    sender.isEnabled = true
                    return
                }else{
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    UserDefaults.standard.set(fname, forKey: "changepn")
                    print(fname)
                    UserDefaults.standard.synchronize()
                    sender.isEnabled = true
                    let vc = self.storyboard?.instantiateViewController(withIdentifier:"pokerline")
                    self.show(vc!, sender:self)

//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "pokerline") as! ChangePasswd
//                    self.dismiss(animated: false, completion: nil)
//                    //                    self.show(vc!, sender:self)
//                    self.personView.present(vc, animated: true, completion: nil)
                }
            }
         
        }
    }
    var emails:String = ""
    var json :[[String:Any]]=[[:]]
    var phonenum :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        json = PersonView.json
        for i in PersonView.json{
            
            phonenum = i["mobile"] as! String
        }
        phone.text = phonenum
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goback(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "winner") as! UITabBarController
        vc.selectedIndex = 2
        present(vc, animated: true, completion: nil)
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

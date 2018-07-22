//
//  ChkPhoneView.swift
//  nome1
//
//  Created by huang-guochao on 2018/6/29.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ChkPhoneView: UIViewController {
    static var aaa = 0
    let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
    let phoneNumber:String = ""
    @IBOutlet weak var ChkPhonetext: UITextField!
    @IBOutlet weak var error: UILabel!
    
    @IBOutlet weak var text1: UILabel!
    @IBAction func GoSub(_ sender: UIButton) {
        sender.isEnabled = false
        if ChkPhonetext.text?.count != 0{
            let verificationCode = ChkPhonetext.text!
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
                    sender.isEnabled = true
                    let vc = self.storyboard?.instantiateViewController(withIdentifier:"paswdv")
                    self.show(vc!, sender:self)
                }
                // User is signed in
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ChkPhonetext.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
       
        var vcstart:ViewController
        vcstart = (self.presentingViewController as! ViewController)
        let userphone = vcstart.phoneNumber1
         self.text1.text = "請輸入傳送至以下號碼的6位數驗證碼 : \(userphone)"
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

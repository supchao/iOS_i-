//
//  ForgetCheck.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/2.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class ForgetCheck: UIViewController {

    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var Forgetchktxt: UITextField!
    let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
    @IBAction func ForgetCk(_ sender: UIButton) {
        if Forgetchktxt.text?.count != 0{
            let verificationCode = Forgetchktxt.text!
            Auth.auth().languageCode = "zh";
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID!,
                verificationCode: verificationCode)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    // ...
                    self.error.text = "驗證碼錯誤"
                    print("error.localizedDescription\(error.localizedDescription)")
                    return
                }
                else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier:"ForgetPwd")
                    self.show(vc!, sender:self)
                }
                // User is signed in
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

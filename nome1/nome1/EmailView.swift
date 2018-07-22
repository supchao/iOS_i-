//
//  EmailView.swift
//  nome1
//
//  Created by huang-guochao on 2018/6/30.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class EmailView: UIViewController {

    
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var EmailField: UITextField!
    @IBAction func OnSub(_ sender: UIButton) {
        if EmailField.text != ""{
            // MARK: 還沒做喔
            let email = EmailField.text!
            let emailtxt = 正則運算add(email)
            if email == emailtxt{
//                UserDefaults.standard.set(email, forKey: "email")
                BeforeLoginRegisterData.email = email
                let vc = self.storyboard?.instantiateViewController(withIdentifier:"usernv")
                self.show(vc!, sender:self)
            }else{
                error.text = "電子信箱格式錯誤"
            }
        }else{
            error.text = "電子信箱格式錯誤"
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        EmailField.becomeFirstResponder()
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

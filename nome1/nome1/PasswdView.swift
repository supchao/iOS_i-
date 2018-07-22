//
//  PasswdView.swift
//  nome1
//
//  Created by huang-guochao on 2018/6/30.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class PasswdView: UIViewController {

    @IBOutlet weak var errorpass: UILabel!
    @IBOutlet weak var passreg: UITextField!
    
    @IBAction func OnPasswd(_ sender: UIButton) {
        if passreg.text != ""{
            let passwd = passreg.text!
            let passwdrare = 正則運算pass(passwd)
            if passwd == passwdrare{
//                RegisterData.passwd = passwd
                UserDefaults.standard.set(passwd, forKey: "passwd")
                BeforeLoginRegisterData.passwd = passwd
                print("passwd\(BeforeLoginRegisterData.passwd)")
                let vc = self.storyboard?.instantiateViewController(withIdentifier:"emailv")
                self.show(vc!, sender:self)
            }else{
                errorpass.text = "密碼不符合規則"
            }
        }else{
            errorpass.text = "密碼長度不足"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        passreg.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

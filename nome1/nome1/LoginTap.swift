//
//  LoginTap.swift
//  nome1
//
//  Created by huang-guochao on 2018/6/29.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class LoginTap: UIViewController {
    
    
    @IBAction func reg(_ sender: Any) {
        let vc = (self.parent as! MainView).storyboard?.instantiateViewController(withIdentifier:"vcView")
        self.present(vc!, animated: true, completion: nil)
       
    }
    @IBOutlet weak var skip: UIButton!
    @IBAction func SkipRegister(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"winner") as! UITabBarController
        vc.selectedIndex = 0
       
//        self.present(vc, animated: true, completion: nil)
        self.show(vc, sender:self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

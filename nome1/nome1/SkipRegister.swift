//
//  SkipRegister.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/10.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class SkipRegister: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    @IBAction func ggg(_ sender: Any) {
        print("will reg")
        let vc = (self.parent as! emptyviewViewController).storyboard?.instantiateViewController(withIdentifier:"vcView")
        self.present(vc!, animated: true, completion: nil)
        
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
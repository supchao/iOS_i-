//
//  OrderHeadViewController.swift
//  shopmember
//
//  Created by YUAN JUNG LI on 2018/7/14.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class OrderHeadViewController: UIViewController {
    
    static var statusController = "0"
    static var viewController = true
    @IBOutlet weak var view0: UIView!
    @IBOutlet weak var label0: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var label2: UILabel!

    @IBOutlet weak var bn0: UIButton!
    @IBOutlet weak var bn1: UIButton!
    @IBOutlet weak var bn2: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func tap0(_ sender: UIButton) {
        bn0.isEnabled = false
        bn1.isEnabled = true
        bn2.isEnabled = true
    
        view0.backgroundColor = UIColor.brown
        label0.textColor = UIColor.brown
        view1.backgroundColor = UIColor.darkGray
        label1.textColor = UIColor.white
        view2.backgroundColor = UIColor.darkGray
        label2.textColor = UIColor.white
      
        OrderBodyViewController.controllerStatus = "0"
    }
    @IBAction func tap1(_ sender: UIButton) {
        bn0.isEnabled = true
        bn1.isEnabled = false
        bn2.isEnabled = true

        view0.backgroundColor = UIColor.darkGray
        label0.textColor = UIColor.white
        view1.backgroundColor = UIColor.brown
        label1.textColor = UIColor.brown
        view2.backgroundColor = UIColor.darkGray
        label2.textColor = UIColor.white

        OrderBodyViewController.controllerStatus = "1"
    }
    @IBAction func tap2(_ sender: UIButton) {
        bn0.isEnabled = true
        bn1.isEnabled = true
        bn2.isEnabled = false

        view0.backgroundColor = UIColor.darkGray
        label0.textColor = UIColor.white
        view1.backgroundColor = UIColor.darkGray
        label1.textColor = UIColor.white
        view2.backgroundColor = UIColor.brown
        label2.textColor = UIColor.brown

        OrderBodyViewController.controllerStatus = "2"
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

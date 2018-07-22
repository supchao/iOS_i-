//
//  OrderViewController.swift
//  shopmember
//
//  Created by YUAN JUNG LI on 2018/7/15.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var orderbody2: UIView!
    @IBOutlet weak var orderbody1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        orderbody1.isHidden = false
        orderbody2.isHidden = true
    
        // Do any additional setup after loading the view.
    }
    
    func viewchange() {
        orderbody1.isHidden = true
        orderbody2.isHidden = false
        OrderBodyViewController2.jsonObjectOrder.removeAll()
       // print(OrderBodyViewController2.jsonObjectOrder.count)
        let childView = childViewControllers[2] as! OrderBodyViewController2
        childView.bntap()
    }
    func viewchange1() {
        orderbody1.isHidden = false
        orderbody2.isHidden = true
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

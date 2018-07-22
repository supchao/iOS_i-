//
//  NavigationController.swift
//  Swift_小專
//
//  Created by Ju hua Tsai on 2018/6/8.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit
//偵測網路狀態
import SystemConfiguration

class NavigationController: UINavigationController,UINavigationControllerDelegate {
    let reach = SCNetworkReachabilityCreateWithName(nil, "google.com.tw")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //在我身上發生的所有事情都送回我自己
        delegate = self
        var n = 0
        
        // Do any additional setup after loading the view.
        //每2秒偵測一次網路狀態
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
            
            if let bn = self.topViewController?.navigationItem.rightBarButtonItem {
                self.checkNetwork(bn)
                print(n)
                n += 1
            }
            
            //self.checkNetwork()
        }
        
    }
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        print("hello:" )
        // bn = 目前頁面的最右邊按鈕
        var bn = viewController.navigationItem.rightBarButtonItem
        // 若 bn = nil 代表按鈕不存在, 此時把按鈕加到目前頁面
        if bn == nil {
            bn = UIBarButtonItem()
            viewController.navigationItem.rightBarButtonItem = bn
        }
        checkNetwork(bn!)
    }
    func checkNetwork(_ bn: UIBarButtonItem) {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reach!, &flags)
        
        DispatchQueue.main.async {
            if flags.contains(.reachable) {
                bn.image = UIImage(named: "連線")?.withRenderingMode(.alwaysOriginal)
            } else {
                bn.image = UIImage(named: "斷線")?.withRenderingMode(.alwaysOriginal)
            }
        }
        
        
        
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

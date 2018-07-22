//
//  BuyNavigationControll.swift
//  Swift_小專
//
//  Created by Ju hua Tsai on 2018/6/13.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit

class BuyNavigationControll: UINavigationController, UINavigationControllerDelegate {

//    @IBAction func onTapGesture(_ sender: UITapGestureRecognizer) {
//        let section = sender.view?.superview?.tag
//        print("onTabGesture")
//
//
//    }
    var badgeCount = Int()
    
    @objc func onclick(_ sender: UIBarButtonItem) {
        let table = storyboard?.instantiateViewController(withIdentifier: "OrderList")
        //present(table!, animated: true)
        //showDetailViewController(table!, sender: nil)
        show(table!, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //在我身上發生的所有事情都送回我自己
        delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        

        // bn = 目前頁面的最右邊按鈕
        var bn = viewController.navigationItem.rightBarButtonItem
        // 若 bn = nil 代表按鈕不存在, 此時把按鈕加到目前頁面
       
        
        if (viewController.title == "選擇品項") {
            if bn == nil {
                bn = UIBarButtonItem()
                bn = UIBarButtonItem(title: "Continue", style: .plain, target: self, action: #selector(self.onclick(_:)))
                viewController.navigationItem.rightBarButtonItem = bn
                bn?.image = UIImage(named: "buy")?.withRenderingMode(.alwaysOriginal)
                bn?.tag = 1000
        
                self.badgeCount = 0
                self.setUpBadgeCountAndBarButton(willShow: viewController)
            }
        }

       // checkNetwork(bn!)
    }
    func setUpBadgeCountAndBarButton(willShow viewController: UIViewController) {
        // badge label
        let label = UILabel(frame: CGRect(x: 25, y: -0, width: 18, height: 18))
        label.layer.borderColor = UIColor.clear.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = label.bounds.size.height / 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.textColor = .white
        label.font = label.font.withSize(10)
        label.backgroundColor = .red
        label.text = "\(self.badgeCount)"
        
        // button
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        rightButton.setBackgroundImage(UIImage(named: "buy"), for: .normal)
        rightButton.addTarget(self, action: #selector(self.onclick(_:)), for: .touchUpInside)
        rightButton.addSubview(label)
        
        // Bar button item
        let rightBarButtomItem = UIBarButtonItem(customView: rightButton)
        viewController.navigationItem.rightBarButtonItem = rightBarButtomItem
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

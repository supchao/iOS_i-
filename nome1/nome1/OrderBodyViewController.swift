//
//  OrderBodyViewController.swift
//  shopmember
//
//  Created by YUAN JUNG LI on 2018/7/14.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class OrderBodyViewController: UIViewController,UICollectionViewDelegate ,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionViewOrder: UICollectionView!
    static var controllerStatus = "0"
    let app = UIApplication.shared.delegate as! AppDelegate
    static var jsonObject:[[String:Any]] = []
    static var sleepController = true
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loginid\(UserKey.loginId)")
        app.orderingData.OrderingQuery(["buyerId":UserKey.loginId],"Order_Api.php")
        app.orderingData.OrderBodyViewController_Delegate(self)
        // Do any additional setup after loading the view.
    }
    func DataLoadReady2() {
        // print(dbKeys.json)
       // OrderMainList = dbKeys.json
       // tableView.reloadData()
    }

    func DataLoadReady() {
        OrderBodyViewController.jsonObject = dbKeys.json
        collectionViewOrder.reloadData()
    }
    
    @IBAction func cell0Tap(_ sender: UIButton) {
        let parentView = parent as! OrderViewController
        let label = sender.superview?.viewWithTag(1) as! UILabel
        let label2 = sender.superview?.viewWithTag(20) as! UILabel
        print(label2.text)
        OrderBodyViewController2.orderOid = label2.text!
        OrderBodyViewController2.orderID = label.text! // 取餐號碼
        
        parentView.viewchange()
        
    }

    func bnTap() {
        OrderBodyViewController.sleepController = true
        app.orderingData.OrderingQuery(["buyerId":UserKey.loginId],"Order_Api.php")
        app.orderingData.OrderBodyViewController_Delegate(self)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OrderBodyViewController.jsonObject.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell0", for: indexPath)
        let item = OrderBodyViewController.jsonObject[indexPath.row]
        if OrderHeadViewController.statusController != "4" {
            let label0 = cell.viewWithTag(1) as! UILabel
            let label1 = cell.viewWithTag(2) as! UILabel
            let label2 = cell.viewWithTag(3) as! UILabel
            let label3 = cell.viewWithTag(4) as! UILabel
            let label4 = cell.viewWithTag(5) as! UILabel
            let label5 = cell.viewWithTag(6) as! UILabel
            let label20 = cell.viewWithTag(20) as! UILabel
            if item["orderNo"] is String {
                label0.text = item["orderNo"] as! String
            }
            if item["bName"] is String {
                label1.text = item["bName"] as! String
            }
            if item["getType"] is String {
                label2.text = item["getType"] as! String
            }
            if item["getDate"] is String,item["getTime"] is String  {
                label3.text = (item["getDate"] as! String).components(separatedBy: " ")[0] as! String + " " + (item["getTime"] as! String)
            }
            if item["orderAmount"] is String {
                label4.text = item["orderAmount"] as! String
            }
            if item["Id"] is String {
                print("id:\(item["Id"])")
                label20.text = item["Id"] as! String
            }
            let orderStat = item["orderStat"] as! String
            label5.textColor = UIColor.blue
            switch orderStat {
            case "0":
                label5.text = "待接單"
                label5.textColor = UIColor.red
            case "1":
                label5.text = "已接單"
            case "2":
                label5.text = "待取餐"
            case "3":
                label5.text = "外送中"
            case "4":
                label5.text = "已取餐"
            case "9":
                label5.text = "已取消"
            default:
                label5.text = "狀態碼：\(orderStat)未定義"
                
            }

        }
        print(indexPath.row)
        return cell
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

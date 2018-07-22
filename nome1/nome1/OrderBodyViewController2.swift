//
//  OrderBodyViewController2.swift
//  shopmember
//
//  Created by YUAN JUNG LI on 2018/7/15.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class OrderBodyViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var orderAmount: UILabel!
    @IBOutlet weak var getDate: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    static var orderID = ""
    static var orderOid = ""
    let app = UIApplication.shared.delegate as! AppDelegate
    static var jsonObjectOrder:[[String:Any]] = []
    static var viewController = true
    
    @IBOutlet weak var tableview0: UITableView!
    override func viewDidLoad() {
        print("hello")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func bntap() {
        OrderBodyViewController2.viewController = true
        //load 訂單明細 by 訂單編號
        print("okkkkkkk")
        print(Goods.orderDetailList)
        for p in Goods.orderDetailList {
            
            let orderno = p["Id"] as! String
            print("orderno\(orderno)")
            print("OrderBodyViewController2.orderOid\(OrderBodyViewController2.orderOid)")
            if orderno == OrderBodyViewController2.orderOid  {
                OrderBodyViewController2.jsonObjectOrder.append(p)
                 print("orderno\(orderno)")
            }
            
        }
        getDate.text = "預計取餐時間： " + (OrderBodyViewController2.jsonObjectOrder[0]["getDate"] as! String).components(separatedBy: " ")[0] + " " + (OrderBodyViewController2.jsonObjectOrder[0]["getTime"] as! String)
        orderAmount.text = OrderBodyViewController2.jsonObjectOrder[0]["orderAmount"] as! String
        let orderStat = OrderBodyViewController2.jsonObjectOrder[0]["orderStat"] as! String
         orderStatus.textColor = UIColor.blue
        switch orderStat {
        case "0":
            orderStatus.text = "待接單"
            orderStatus.textColor = UIColor.red
        case "1":
            orderStatus.text = "已接單"
        case "2":
            orderStatus.text = "待取餐"
        case "3":
            orderStatus.text = "外送中"
        case "4":
            orderStatus.text = "已取餐"
        case "9":
            orderStatus.text = "已取消"
        default:
            orderStatus.text = "狀態碼：\(orderStat)未定義"
        }

        tableview0.reloadData()

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if OrderBodyViewController2.jsonObjectOrder.count == 0{
            return 0
        }
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return OrderBodyViewController2.jsonObjectOrder.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        switch indexPath.section {
        case 0:
            let item = OrderBodyViewController2.jsonObjectOrder[0]
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            let label0 = cell.viewWithTag(1) as! UILabel
            let label1 = cell.viewWithTag(2) as! UILabel
            let label2 = cell.viewWithTag(3) as! UILabel
            
            if item["buyerName"] is String {
                label0.text = item["buyerName"] as? String
            }
            if item["buyerAddress"] is String {
                label1.text = item["buyerAddress"] as? String
            }
            if item["buyerMobil"] is String {
                label2.text = "電話:" + (item["buyerMobil"] as! String)
            }
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            let label0 = cell.viewWithTag(1) as! UILabel
            label0.text = "商品(\(OrderBodyViewController2.jsonObjectOrder.count))"
        default:
            let item = OrderBodyViewController2.jsonObjectOrder[indexPath.row]
            cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
            let label0 = cell.viewWithTag(1) as! UILabel
            let label1 = cell.viewWithTag(2) as! UILabel

            
            if item["goodsName"] is String {
                label0.text = item["goodsName"] as? String
            }
            if item["Price"] is String {
                label1.text = (item["Price"] as! String) + " X " + (item["qty"] as! String) + " = " +  (item["totAmount"] as! String)
            }

        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 45
        case 1:
            return 45
        default:
            return 70
        }

    }
    @IBAction func goback(_ sender: UIButton) {
        let parentView = parent as! OrderViewController
        parentView.viewchange1()
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

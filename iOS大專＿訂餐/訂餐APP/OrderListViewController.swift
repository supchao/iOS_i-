//
//  ShowTableViewController.swift
//  Swift_小專
//
//  Created by Ju hua Tsai on 2018/6/12.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   let app = UIApplication.shared.delegate as! AppDelegate
   var OrderMainList = [[String:Any]] ()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let mobile = UserDefaults.standard.string(forKey: "phonenum")
        print(mobile)
        let json:[[String:Any]] = GetUserIdViewController.getId(mobile!)
//        print("json[0][loginId]:\(json[0]["loginId"])")
        if mobile != ""{
        let loginid = json[0]["loginId"] as! String
            app.orderingData.OrderingQuery(["buyerId":"\(loginid)"],"Order_Api.php")
            //GetDBListFromSql.php
            app.orderingData.OrderMain_Delegate(self)
        }
       
        //tableView.alpha = 0

    }
    func DataLoadReady() {
        print("BDKeys:\(dbKeys.json)")
        OrderMainList = dbKeys.json
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        tableView.rowHeight = 105
        print("json.count=\(dbKeys.json.count)")
        return OrderMainList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text = ShowTableViewController.list[indexPath.row]
        // Configure the cell...
        let orderDate2 = cell.viewWithTag(200) as! UILabel
        let orderNo = cell.viewWithTag(120) as! UILabel
        let getTime = cell.viewWithTag(130) as! UILabel
        let orderStat = cell.viewWithTag(140) as! UILabel
        let getType = cell.viewWithTag(150) as! UILabel
        let orderAmount = cell.viewWithTag(160) as! UILabel
        let bname = cell.viewWithTag(170) as! UILabel
       
        let date = OrderMainList[indexPath.row]["orderDate"] as! String
        
        //print(date.components(separatedBy: " ")[0])
        orderDate2.text = date.components(separatedBy: " ")[0]
        orderNo.text = OrderMainList[indexPath.row]["orderNo"] as! String
        getTime.text =  OrderMainList[indexPath.row]["getTime"] as! String
        orderStat.text = OrderMainList[indexPath.row]["orderStat"] as! String
        getType.text = OrderMainList[indexPath.row]["getType"] as! String
        orderAmount.text = OrderMainList[indexPath.row]["orderAmount"] as! String
        bname.text = OrderMainList[indexPath.row]["bname"] as! String

        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

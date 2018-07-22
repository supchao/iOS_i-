//
//  StoreTableViewController.swift
//  Swift_小專
//
//  Created by Ju hua Tsai on 2018/6/12.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit
import SafariServices
class StoreTableViewController: UITableViewController {

    
    let list = [["每日精選咖啡\nBrewed Coffee","冰每日精選咖啡\nIced Brewed Coffee","咖啡密斯朵\nCaffé Misto"],
                ["茶瓦納洋甘菊花草茶\nTeavana Chamomile Herbal Blend Tea","茶瓦納英式早餐紅茶\nTeavana English Breakfast Tea","東方美人\nOriental Beauty Oolong Tea","紅玉紅茶\nRuby Black Tea","阿里山烏龍茶\nAlishan Oolong Tea"],
                ["夜色摩卡星冰樂\nMidnight Mocha Frappuccino® \nBlended Beverage","咖啡星冰樂\nCoffee Frappuccino® \nBlended Beverage","焦糖星冰樂\nCaramel Frappuccino® \nBlended Beverage","摩卡星冰樂\nMocha Frappuccino® \nBlended Beverage","濃縮星冰樂\nEspresso Frappuccino® \nBlended Beverage"],
                ["xxx","kkkk"]]
    let titlelist = ["經典咖啡飲料","茶瓦納","星冰樂","冷萃咖啡"]
    private var sectionIndex = 0
    
    var isSessionCollapes: [Bool] = [false,false,false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

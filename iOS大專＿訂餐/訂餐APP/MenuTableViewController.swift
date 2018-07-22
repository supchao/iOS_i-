//
//  MenuTableViewController.swift
//  20180530_app1
//
//  Created by Ju hua Tsai on 2018/5/30.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit
import SafariServices

class MenuTableViewController: UITableViewController {

    let list = [["每日精選咖啡\nBrewed Coffee","冰每日精選咖啡\nIced Brewed Coffee","咖啡密斯朵\nCaffé Misto"],
                ["茶瓦納洋甘菊花草茶\nTeavana Chamomile Herbal Blend Tea","茶瓦納英式早餐紅茶\nTeavana English Breakfast Tea","東方美人\nOriental Beauty Oolong Tea","紅玉紅茶\nRuby Black Tea","阿里山烏龍茶\nAlishan Oolong Tea"],
                ["夜色摩卡星冰樂\nMidnight Mocha Frappuccino® \nBlended Beverage","咖啡星冰樂\nCoffee Frappuccino® \nBlended Beverage","焦糖星冰樂\nCaramel Frappuccino® \nBlended Beverage","摩卡星冰樂\nMocha Frappuccino® \nBlended Beverage","濃縮星冰樂\nEspresso Frappuccino® \nBlended Beverage"],
                ["xxx","kkkk"]]
    let titlelist = ["經典咖啡飲料","茶瓦納","星冰樂","冷萃咖啡"]
    private var sectionIndex = 0
    
    var isSessionCollapes: [Bool] = [false,false,false,false]

    
    @IBAction func onTapGesture(_ sender: UITapGestureRecognizer) {
        let section = sender.view?.superview?.tag
        isSessionCollapes[section!] = !isSessionCollapes[section!]
        tableView.reloadSections(IndexSet(integer: section!), with: .automatic)
    }
    
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

    // MARK: - 表格第一階段對話
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return list.count
    }
    // MARK: 表格第二階段對話
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (isSessionCollapes[section]) ? 0 : list[section].count
        
        
    }
    // MARK: 表格第三階段對話
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = list[indexPath.section][indexPath.row]
        cell.textLabel?.numberOfLines = 0   //可顯示多行
        // onfigure the cell...
        
        return cell
    }
    
    // MARK: - 設定儲存格高度
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 && isSessionCollapes[indexPath.section] == true {
            return 0
        }
        return UITableViewAutomaticDimension   //隨內容自動調整大小
    }
    // MARK: - 設定表格標題名稱
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titlelist[section]
    }
    // MARK: - 設定表格標題位置
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let v = view as!UITableViewHeaderFooterView
        
        v.textLabel?.textColor = .white
        
        v.textLabel?.textAlignment = .center
        v.tag = section
        //接上手勢 (點選標題時可以連接手勢功能）
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTapGesture(_:)))
        v.contentView.addGestureRecognizer(tap)
        
    }
    
    // MARK: 得知使用者點選的儲存格
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            showTutorial("https://www.starbucks.com.tw/products/drinks/product.jspx?id=188&catId=5")
        case 1:
            showTutorial("https://www.starbucks.com.tw/products/drinks/product.jspx?id=18&catId=5")
            
        default:
            break
        }

        
    }
    func showTutorial(_ which: String) {
        if let url = URL(string: which) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

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

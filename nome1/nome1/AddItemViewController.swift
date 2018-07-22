//
//  AddItemViewController.swift
//  Swift_小專
//
//  Created by Ju hua Tsai on 2018/6/14.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var viewnotice: UILabel!
    var sectionList = [[String:String]]()
    var dataList = [[[String: Any]]] ()
    //var checked = [Bool](
    var notice:String=""

    
    @IBAction func stepper(_ sender: UIStepper) {
        Goods.qty = Int(sender.value)
        self.showTotal()

    }
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    @IBAction func onCancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var totPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var alertView: UIView!
    @IBAction func onDismiss(_ sender: UIButton) {
        //let vc = presentingViewController as! SelectGoodsViewController
        //vc.完成後請通知我("text.text")
        //把前一個畫面的可control物件設定恢復isEnabled = true
       // toggleControlEnable(true)


//        let vc =  self.parent as? SelectGoodsViewController
//        vc!.showBadgeCount()
        let checkError = checkData()
        if checkError != "" {
            let alertController = UIAlertController( title: "新增餐點明細", message: checkError
                , preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            Goods.badgeCount += Goods.qty
            let str = ["goodsId":"\(Goods.goodsId)","goodsName":"\(Goods.mergeName)","Price1":"\(Goods.Price1)","addPrice":"\(Goods.addPrice)","qty":"\(Goods.qty)","totAmount":"\(Goods.totAmount)"]
            Goods.orderList.append(str)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func savenote(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "請輸入備註", preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "註解"
            textfield.text = self.notice
        }
        let yes = UIAlertAction(title: "確定", style: .destructive) { (action) in
            if let note = alert.textFields![0].text{
                if self.notice.count > 0{
                    self.notice = note
                    self.viewnotice.text = "\(self.notice)"
                }else{
                     self.notice = note
                    self.viewnotice.text = "\(self.notice)"
                }
            }else{
                self.notice = ""
                self.viewnotice.text = ""
            }
            
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(yes)
        alert.addAction(cancel)
         present(alert, animated: true, completion: nil)
    }
    
    func checkData() ->String {
        var i = 0
        var j = 0
        var mergeName = ""
        var chkError = ""
        var str = ""
        while i < sectionList.count {
            let name = sectionList[i]["name"] as! String
            let type = sectionList[i]["type"] as! String
            str = ""
            j = 0
            while j < dataList[i].count {
                let ischeck =  dataList[i][j]["checked"] as! Bool
                let chkName = dataList[i][j]["name"] as! String
                if ischeck {
                    str +=  "/" +  chkName
                }

                j += 1
            }
            if type == "單選" && str == "" {
                chkError = "請選擇：\(name)"
            } else {
                if str != "" {
                    mergeName +=  str
                }
            }
            i += 1
        }
        if notice.count > 0{
             Goods.mergeName = Goods.goodsName + mergeName + " /\(notice)"
        }else {
            Goods.mergeName = Goods.goodsName + mergeName + " "
        }
        
        return chkError

    }
    private func toggleControlEnable (_ flag: Bool) {
        //把前一個畫面的 isEnabled = false
        for v in (presentingViewController?.view.subviews)! {
            if v is UIControl {
                if v is UIButton, v.tag == 0 {
                    continue
                }
                (v as! UIControl).isEnabled = flag
            }
        }
    }
    func loadData() {
        var cnt = 0
        while cnt <  Goods.goodsTasteList.count {
            print(Goods.goodsTasteList[cnt])
            print(type(of: Goods.goodsTasteList[cnt]))
            let TastyName =  ("\(Goods.goodsTasteList[cnt])")
            cnt += 1
            
            for p in Goods.tasteList {
                let TasteProject = p["TasteProject"] as! String
                if TastyName == TasteProject {
                    let TasteItem = p["TasteItem"] as! String
                    let Check = p["Check"] as! String
                    sectionList.append(["name" : TasteProject, "type" : (Check == "0" ? "單選":"複選")])
                    var tmpList = [[String : Any]]()
                    
                    let list = Global.StringToArray(TasteItem, ",")
                    if list.count > 0 {
                        var i = 0
                        while i < list.count {
                            let tt = "\(list[i])"
                            // print(tt)
                            let taste = Global.StringToArray(tt, ":")
                            if taste.count == 1 {
                                let name = "\(taste[0])"
                                tmpList.append(["name" : name, "checked" : false])
                            } else {
                                let name = "\(taste[0])"
                                let value = "\(taste[1])"
                                tmpList.append(["name" : name, "checked" : false, "addPrice" : Int(value) ])
                            }
                            i += 1
                        }
                        dataList.append(tmpList)
                    }
                    
                }
            }
            
            
        }
//        sectionList.append(["name" : "冰塊", "type" : "單選"])
//        sectionList.append(["name" : "糖度", "type" : "單選"])
//        sectionList.append(["name" : "加料", "type" : "複選"])
// 
//        dataList.append([["name" : "正常冰","checked" : false],["name" : "少冰","checked" : false],["name" : "去冰","checked" : false]])
//        dataList.append([["name" : "正常","checked" : false],["name" : "少糖","checked" : false],["name" : "半糖","checked" : false], ["name" : "微糖","checked" : false], ["name" : "無糖","checked" : false]])
//        dataList.append([["name" : "大杯","checked" : false, "addPrice" : 20],["name" : "紅豆","checked" : false, "addPrice" : 5],["name" : "花生","checked" : false, "addPrice" : 5],["name" : "珍珠","checked" : false, "addPrice" : 5],["name" : "蒟蒻","checked" : false, "addPrice" : 5]])

    }
    func showTotal(){
        button.setTitle("新增 \(Goods.qty) 份至購物車", for: .normal)
        print(button.title(for: .normal) as! String)
        Goods.totAmount = (Goods.Price1 + Goods.addPrice) * Goods.qty
        totPrice.text = "$ \(Goods.totAmount)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
        
        alertView.layer.cornerRadius = 15
        
//        button?.drawCircle(UIColor.white.cgColor, UIColor(red: 154/255, green: 196/255, blue: 61/255, alpha: 1).cgColor, 20)
//        print("Goods.goodsImage:\(Goods.goodsImage)")
        itemImage.image = UIImage(data: Goods.goodsImage!)
        itemName.text = Goods.goodsName
      
        itemPrice.text = "$ \(Goods.Price1)"
        Goods.qty = 1
        Goods.addPrice = 0
        Goods.totAmount = 0
        self.showTotal()

        
        //把前一個畫面的可control物件設定成灰色 isEnabled = false
        //toggleControlEnable(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 表格第一階段對話
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //        return storeData.count
        return sectionList.count
    }
    // MARK: 表格第二階段對話
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //        return (isSessionCollapes[section]) ? 0 : storeData[section].count
        
        return dataList[section].count
    }
    // MARK: 表格第三階段對話
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let check = cell.viewWithTag(110) as! UIButton
        let name = cell.viewWithTag(120) as! UILabel
        let addprice = cell.viewWithTag(130) as! UILabel

        name.text = dataList[indexPath.section][indexPath.row]["name"] as? String
        //print("section=\(indexPath.section) , row=\(indexPath.row)")
        //print(dataList[indexPath.section][indexPath.row]["name"] )
        addprice.text =  dataList[indexPath.section][indexPath.row]["addPrice"] as? String
        check.setImage(UIImage(named: (dataList[indexPath.section][indexPath.row]["checked"] as! Bool) == true ? "checked" : "unchecked"), for: .normal)
        name.restorationIdentifier = dataList[indexPath.section][indexPath.row]["name"] as? String
        if dataList[indexPath.section][indexPath.row]["addPrice"] != nil {
            addprice.text = "+$\(dataList[indexPath.section][indexPath.row]["addPrice"] as! Int)"
          
        }
        
        return cell
    }
    
        // MARK: - 設定表格標題名稱
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sectionList[section]["name"]
    
        }
        // MARK: - 設定表格標題位置
        func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            let v = view as!UITableViewHeaderFooterView
    
            v.textLabel?.textColor = .blue
    
            v.textLabel?.textAlignment = .center
            v.tag = section

    
        }
    // MARK: 得知使用者點選的儲存格
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = sectionList[indexPath.section]["type"] as! String
        if type == "單選" {
            singleCheck(indexPath.section, indexPath.row)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            
            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
                let check = cell.viewWithTag(110) as! UIButton
                let ischeck = dataList[indexPath.section][indexPath.row]["checked"] as! Bool
                let addprice = cell.viewWithTag(130) as! UILabel
                dataList[indexPath.section][indexPath.row]["checked"] = !ischeck
                check.setImage(UIImage(named: (!ischeck) == true ? "checked" : "unchecked"), for: .normal)
                if dataList[indexPath.section][indexPath.row]["addPrice"] != nil {
                    Goods.addPrice += ((!ischeck) == true ? 1 : -1) * (dataList[indexPath.section][indexPath.row]["addPrice"] as! Int)
                    self.showTotal()
                }

            }
        }
  
    }
    func singleCheck(_ section: Int, _ index: Int) {
        //tableView.deselectRow(at: indexPath, animated: true)
        var i = 0
        while i < dataList[section].count {
            let indexPath = IndexPath(row: i, section: section)
            tableView.deselectRow(at: indexPath, animated: true)
            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
                let check = cell.viewWithTag(110) as! UIButton
                let ischeck = (i == index ) ? true:false
                dataList[section][i]["checked"] = ischeck
                check.setImage(UIImage(named: (ischeck) == true ? "checked" : "unchecked"), for: .normal)
            }
            i += 1
        }
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

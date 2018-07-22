//
//  listViewController.swift
//  Swift_小專
//
//  Created by Ju hua Tsai on 2018/6/12.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit

class listViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     let app = UIApplication.shared.delegate as! AppDelegate
//    @IBOutlet weak var segmentC: UISegmentedControl!
    var tableanotherv = listviewtablev()
//    @IBOutlet weak var image: UIImageView!
//    @IBOutlet weak var name: UILabel!
//    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var ondis: UIButton!
    
    
    @IBOutlet weak var datatimecons: NSLayoutConstraint!
    
//    @IBOutlet weak var takedata: UILabel!
//    @IBOutlet weak var taketime: UILabel!
    
    @IBOutlet var tapGest: UITapGestureRecognizer!
    
    
    @IBAction func tapGestfunc(_ sender: UITapGestureRecognizer) {
        datatimecons.constant = 0
        
    }
//    @IBAction func segmentchange(_ sender: Any) {
//        if segmentC.selectedSegmentIndex == 0{
//            var a = takedata.text!
//            var b = taketime.text!
//            var rangea = a.index(after: a.startIndex)..<a.endIndex
//            var rangeb = b.index(after: b.startIndex)..<b.endIndex
//            takedata.text = "取\(a[rangea])"
//            taketime.text = "取\(b[rangeb])"
//        }
//        if segmentC.selectedSegmentIndex == 1{
//            var a = takedata.text!
//            var b = taketime.text!
//            var rangea = a.index(after: a.startIndex)..<a.endIndex
//            var rangeb = b.index(after: b.startIndex)..<b.endIndex
//            takedata.text = "送\(a[rangea])"
//            taketime.text = "送\(b[rangeb])"
//        }
//
//    }
    
    @IBAction func onAddOrder(_ sender: Any) {
            print(dbKeys.phpURL)
            
            ondis.isEnabled = false
            let url = URL(string: dbKeys.phpURL + "InsertOrder.php")
            //let url = URL(string: "http://localhost/Ordering/InsertOrder.php")
            var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        
            let orderMain = OrderMainToJsonString()
            let orderDetail = OrderDetailToJsonString()
            let  postfields = "OrderMain=\(orderMain)&OrderDetail=\(orderDetail)"
            print("postfields")
            print(postfields)
            request.httpBody = postfields.data(using: .utf8)
            request.httpMethod = "POST"
            //MARK: URLSession 建立
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let q = DispatchQueue.global()
            q.async {
                sleep(1)
                //MARK: request
                let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data {
                        let html = String(data:data,encoding:.utf8)
                        if let html = html{
                            print("go html")
                            print(html)
                            if html == "" {
                                    print("ok")
                                    Goods.StoreListReload = true
                                self.ondis.isEnabled = true
                                self.app.orderingData.LoadOrderDetailByBuyerId()
                                let vcpre = self.storyboard?.instantiateViewController(withIdentifier: "winner") as! UITabBarController
                                vcpre.selectedIndex = 0
                                self.present(vcpre, animated: false, completion: {
                                    StoreListViewController.appear()
                                })
                                //---------
                                print(html)
//                                DispatchQueue.main.async {
//                                    self.dismiss(animated: true, completion: nil)
//                                }
                            }
                            else {
                                print("error")
                            }
                        }else{
                            //MARK: 沒東西
                            
                            print("路過")
                        }
                    }
                    
                })
                dataTask.resume()
            }
            

    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        name.text = Goods.storeName
//        address.text = Goods.storeAddress
//
//        if Goods.storeImage.count > 0{
//            let shopimage = Data(base64Encoded: Goods.storeImage )
//            image.image = UIImage(data: shopimage!)
//        }
        
        
        var i = 0
        Goods.orderAmount = 0
        while i < Goods.orderList.count {
            print(Goods.orderList[i]["totAmount"] as! String)
            let amount = Goods.orderList[i]["totAmount"] as! String
            Goods.orderAmount += Int(amount)!
            i += 1
        }
        // Do any additional setup after loading the view.
       // showBadgeCount()

        
    }
    func OrderMainToJsonString()->String {

        var ret = ""
        var segment = ["外帶","外送"]
        let nowDate = NSDate()
        let formatter = DateFormatter()
        
        // 先設置日期時間顯示的格式
//        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.dateFormat = "yyyy-MM-dd"
        var inde = 0
        let orderDate = formatter.string(from: nowDate as Date)
        if listviewtablev.die == true{
            inde = 0
            print("外帶")
        }
        if listviewtablev.die == false{
            inde = 1
            print("外送")
        }
        var tablev: listviewtablev!
        for vc in (self.childViewControllers){
            if vc.restorationIdentifier == "liiv"{
                tablev = vc as! listviewtablev
            }
        }
        let addrr = tablev.toaddress.text as! String
        let getType = segment[inde]
        let getDate = tablev.orderdata.text as! String
        let getTime = tablev.ordertime.text as! String

        let phonenum = UserDefaults.standard.string(forKey: "phonenum")
        let json:[[String:Any]] = GetUserIdViewController.getId(phonenum!)
        print("json\(json)")
        for i in json{
            UserKey.loginId = i["loginId"] as! String
            UserKey.name = i["name"] as! String
            UserKey.email = i["name"] as! String
            
            UserKey.mobil = i["mobile"] as! String
        }
        UserKey.address = addrr
        print("addrr:\(addrr)")
        let note = tablev.notice.text as! String
        print("note\(note)")
        ret = "["
        
        ret = ret + "{\"bId\" : \(Goods.storeId),"
        ret = ret + "\"orderDate\" : \"\(orderDate)\","
        ret = ret + "\"orderAmount\" : \(Goods.orderAmount),"
        ret = ret + "\"buyerId\" : \(UserKey.loginId),"
        ret = ret + "\"buyerName\" : \"\(UserKey.name)\","
        ret = ret + "\"buyerMobil\" : \"\(UserKey.mobil)\","
        ret = ret + "\"buyerAddress\" : \"\(UserKey.address)\","
        ret = ret + "\"getType\" : \"\(getType)\","
        ret = ret + "\"getDate\" : \"\(getDate)\","
        ret = ret + "\"getTime\" : \"\(getTime)\","
        ret = ret + "\"getNote\": \"\(note)\"}"
        ret += "]"
        return  ret
        
    }
    func OrderDetailToJsonString()->String {
        var i = 0
        var ret = ""
        ret = "["
        while i < Goods.orderList.count {
            ret = ret + "{\"itemNo\" : \(i+1),"
            ret = ret + "\"goodsId\" : \"\(Goods.orderList[i]["goodsId"] as! String)\","
            ret = ret + "\"goodsName\" : \"\(Goods.orderList[i]["goodsName"] as! String)\","
            ret = ret + "\"Price\" : \(Goods.orderList[i]["Price1"] as! String),"
            ret = ret + "\"addPrice\" : \(Goods.orderList[i]["addPrice"] as! String),"
            ret = ret + "\"qty\" : \(Goods.orderList[i]["qty"] as! String),"
            ret = ret + "\"totAmount\" : \(Goods.orderList[i]["totAmount"] as! String)}"
            i += 1
            if i < Goods.orderList.count {
                ret += ","
            }

        }
        ret += "]"
        return  ret
        
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    func showBadgeCount() {
        let vc =  self.parent as? BuyNavigationControll
        vc?.badgeCount = Goods.badgeCount
        vc?.setUpBadgeCountAndBarButton(willShow: self)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 表格第一階段對話
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //        return storeData.count
        return 1
    }
    // MARK: 表格第二階段對話
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //        return (isSessionCollapes[section]) ? 0 : storeData[section].count
        
        return Goods.orderList.count
    }
    // MARK: 表格第三階段對話
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let name = cell.viewWithTag(110) as! UILabel
        let qty = cell.viewWithTag(120) as! UILabel
        let totAmount = cell.viewWithTag(130) as! UILabel
        name.text = Goods.orderList[indexPath.row]["goodsName"] as? String
        qty.text = Goods.orderList[indexPath.row]["qty"] as? String
        totAmount.text = Goods.orderList[indexPath.row]["totAmount"] as? String

        return cell
    }
    
    // MARK: - 設定表格標題名稱
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "訂購總金額 NT$\(Goods.orderAmount)"
        
    }
    // MARK: - 設定表格標題位置
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let v = view as!UITableViewHeaderFooterView
        
        v.textLabel?.textColor = .orange
        
        v.textLabel?.textAlignment = .center
        v.tag = section
        
        
    }
    // MARK: 得知使用者點選的儲存格
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("goodid:\(Goods.orderList[indexPath.row]["goodsId"])")
        print("goodid:\(Goods.orderList[indexPath.row]["goodsName"])")
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

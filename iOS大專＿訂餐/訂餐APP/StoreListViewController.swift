//
//  StoreListViewController.swift
//  Swift_小專
//
//  Created by Ju hua Tsai on 2018/6/12.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit
import SafariServices
import CoreLocation

class StoreListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    let app = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var 目前位置: UILabel!
    var fullSize :CGSize!
    var myUserDefaults :UserDefaults!
    var myLocationManager :CLLocationManager!
    

    var fetchType :String!
    var storeData:  [[String: Any]] = [[:]]

    var StoreDataForDistance :[Coordinate]!
    // 超過多少距離才重新取得有限數量資料 (公尺)
    let limitDistance = 500.0
    
    // 有限數量資料的個數
    let limitNumber = 100
    var addr = ""
    var storeDataAll = Goods.storeList

    
    
    private var sectionIndex = 0
    
    var isSessionCollapes: [Bool] = [false,false,false,false]
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func onTapGesture(_ sender: Any) {
        let section = (sender as AnyObject).view?.superview?.tag
        isSessionCollapes[section!] = !isSessionCollapes[section!]
        tableView.reloadSections(IndexSet(integer: section!), with: .automatic)
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // 取得儲存的預設資料
        self.myUserDefaults = UserDefaults.standard
        storeData = [[String : Any]]()
        

        if Goods.storeList.count == 0 {
            app.orderingData.OrderingQuery([:],"GetStoreList.php")
            app.orderingData.StoreListView_Delegate(self)
            tableView.alpha = 0
        } else {
            // 建立一個 CLLocationManager
            myLocationManager = CLLocationManager()
            myLocationManager.delegate = self
            myLocationManager.distanceFilter = kCLLocationAccuracyHundredMeters
            myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            
        }
//-----------------------------
        self.tabBarController?.tabBar.isHidden = false
        if storeData.count != 0 {
            if (CLLocationManager.authorizationStatus() == .denied) {
                // 設置定位權限的紀錄
                self.myUserDefaults.set(false, forKey: "locationAuth")
                self.myUserDefaults.synchronize()
            } else if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
                // 設置定位權限的紀錄
                self.myUserDefaults.set(true, forKey: "locationAuth")
                self.myUserDefaults.synchronize()
                
                // 開始定位自身位置
                myLocationManager.startUpdatingLocation()
            }
            //loadData()
        } else {
            if Goods.StoreListReload == true  {
                Goods.StoreListReload = false
                self.myUserDefaults.set(0.0, forKey: "RecordLatitude")
                self.myUserDefaults.set(0.0, forKey: "RecordLongitude")
                self.myUserDefaults.synchronize()
                loadData()
            }
            if BeforeLoginRegisterData.firsttoken == false  {
                self.myUserDefaults.set(0.0, forKey: "RecordLatitude")
                self.myUserDefaults.set(0.0, forKey: "RecordLongitude")
                self.myUserDefaults.synchronize()
                loadData()
            }
          BeforeLoginRegisterData.firsttoken = false 
        }
    }
    func DataLoadReady() {
        // print(dbKeys.json)
        Goods.storeList = dbKeys.json
        storeDataAll = Goods.storeList
        tableView.reloadData()
        tableView.alpha = 1
        
        // 建立一個 CLLocationManager
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
    }
    func loadData() {
        // 有定位權限
        let locationAuth = myUserDefaults.object(forKey: "locationAuth") as? Bool
        if locationAuth != nil && locationAuth! {
            // 取得目前使用者座標
            let userLatitude = myUserDefaults.object(forKey: "userLatitude") as? Double
            let userLongitude = myUserDefaults.object(forKey: "userLongitude") as? Double
            let userLocation = CLLocation(latitude: userLatitude!, longitude: userLongitude!)
            
            // 記錄的座標
            let recordLatitude = myUserDefaults.object(forKey: "RecordLatitude") as? Double ?? 0.0
            let recordLongitude = myUserDefaults.object(forKey: "RecordLongitude") as? Double ?? 0.0
            let recordLocation = CLLocation(latitude: recordLatitude, longitude: recordLongitude)
            // 取得目前使用者座標
            目前位置.text = "    目前座標:\(userLatitude!) , \(userLongitude!) "
            Global.CLLocationToAddress(userLatitude!, userLongitude!) { (result) in
                self.目前位置.text = "   定位點：" + result
                BeforeLoginRegisterData.address = result
            }

            // 超過限定距離才重新取得有限數量資料
            if userLocation.distance(from: recordLocation) > self.limitDistance {
                
                for i in 0..<storeDataAll.count {
                    var distance = 0

                    if userLatitude != nil {
                        let userLocation = CLLocation(latitude: userLatitude!, longitude: userLongitude!)
                        
                        // 這筆資料的座標
                        var thisDataLatitude = 0.0
                        
                        if let num = storeDataAll[i]["Latitude"] as? String {
                            thisDataLatitude = Double(num)!
                        }
                        
                        var thisDataLongitude = 0.0
                        if let num = storeDataAll[i]["Longitude"] as? String {
                            thisDataLongitude = Double(num)!
                        }
                        if thisDataLatitude == 0.0 && thisDataLongitude == 0.0 {
                            
                        } else {
                            let thisDataLocation = CLLocation(latitude: thisDataLatitude, longitude: thisDataLongitude)
                            
                            distance = Int(userLocation.distance(from: thisDataLocation))
                        }
                    
                    }
                    storeDataAll[i]["Distance"] = distance

                }
                // 更新記錄的座標
                myUserDefaults.set(userLatitude, forKey: "RecordLatitude")
                myUserDefaults.set(userLongitude, forKey: "RecordLongitude")
                myUserDefaults.synchronize()
                //依距離排序
                storeData = storeDataAll.sorted { (d1, d2) -> Bool in
                    return (d1["Distance"] as! Int) < (d2["Distance"] as! Int)}
                
                tableView.reloadData()
            }
        } else
        {
            storeData = storeDataAll
            tableView.reloadData()
            
        }


  
//        for p in storeData {
//            print("\(p["name"]!)距離\(p["Distince"]!)")
//        }
    
    }
    static func appear(){
        print("print")
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        tableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
        if storeData.count != 0 {
            if (CLLocationManager.authorizationStatus() == .denied) {
                // 設置定位權限的紀錄
                self.myUserDefaults.set(false, forKey: "locationAuth")
                self.myUserDefaults.synchronize()
            } else if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
                // 設置定位權限的紀錄
                self.myUserDefaults.set(true, forKey: "locationAuth")
                self.myUserDefaults.synchronize()
                
                // 開始定位自身位置
                myLocationManager.startUpdatingLocation()
            }
            //loadData()
        }


    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//
//        // 停止定位自身位置
//        myLocationManager.stopUpdatingLocation()
//    }
    // MARK: CLLocationManagerDelegate Methods
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation :CLLocation = locations[0] as CLLocation
        
        // 更新自身定位座標
        self.myUserDefaults.set(currentLocation.coordinate.latitude, forKey: "userLatitude")
        self.myUserDefaults.set(currentLocation.coordinate.longitude, forKey: "userLongitude")
        self.myUserDefaults.synchronize()
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        
        
        loadData()

        

        
    }
    
    // 更改定位權限時執行
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(false, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        } else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(true, forKey: "locationAuth")

            self.myUserDefaults.synchronize()
            
            // 開始定位自身位置
            myLocationManager.startUpdatingLocation()
        }
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
       
        return storeData.count
    }
    // MARK: 表格第三階段對話

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.lightText
        cell.selectedBackgroundView = bgColorView
        
        //距離
        var detail = ""
        let distance = storeData[indexPath.row]["Distance"] as! Int
        
        if distance > 20000 {
            detail = "超過 20 KM"
        } else if distance > 1000 {
            detail = "\(Double(Int(distance / 100)) / 10.0) KM"
        } else if distance > 100 {
            detail = "\(Int(distance / 10))0 M"
        } else {
            detail = "\(distance) M"
        }
        

        let name = cell.viewWithTag(100) as! UILabel
        let addr = cell.viewWithTag(110) as! UILabel
        let logo = cell.viewWithTag(120) as! UIImageView
        // 将 base64的图片字符串转化成Data
//        do{
//            let imageData = try Data(contentsOf: URL(string: strBase64)!)
//            let image = UIImage(data: imageData)
//            return image!
//
//        } catch{ return nil }
        if storeData[indexPath.row]["logo"] as? String != nil {
            print(storeData[indexPath.row]["logo"] as! String)
            let imageData2 = try(Data(base64Encoded: (storeData[indexPath.row]["logo"] as! String)))
            
            // 将Data转化成图片
            logo.image = UIImage(data: (imageData2 ?? nil)!)
        } else {
            logo.image = nil
        }


        name.text = storeData[indexPath.row]["name"] as! String
        addr.text =  "🏠" + (storeData[indexPath.row]["addr"] as! String) + " " + detail
        //logo.image = UIImage(named: )
        //logo.layer.cornerRadius = (logo.frame.height)/2
//        logo.layer.borderWidth = 2
//        logo.layer.borderColor = UIColor.orange.cgColor
//        logo.layer.masksToBounds = true

        
        return cell
    }
    
    // MARK: - 設定儲存格高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 && isSessionCollapes[indexPath.section] == true {
            return 0
        }
        return UITableViewAutomaticDimension   //隨內容自動調整大小
    }
//    // MARK: - 設定表格標題名稱
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return titlelist[section]
//       
//    }
//    // MARK: - 設定表格標題位置
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        let v = view as!UITableViewHeaderFooterView
//        
//        v.textLabel?.textColor = .blue
//        
//        v.textLabel?.textAlignment = .center
//        v.tag = section
//        //接上手勢 (點選標題時可以連接手勢功能）
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTapGesture(_:)))
//        v.contentView.addGestureRecognizer(tap)
//        
//    }
//    
    // MARK: 得知使用者點選的儲存格
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Goods.storeId = storeData[indexPath.row]["id"] as! String
        Goods.storeName = storeData[indexPath.row]["name"] as! String
        Goods.storeAddress =  "🏠" + (storeData[indexPath.row]["addr"] as! String)
        if storeData[indexPath.row]["logo"] as? String != nil {
            Goods.storeImage = storeData[indexPath.row]["logo"] as! String
        } else {
            Goods.storeImage = ""
        }
       // Goods.storeImage = storeData[indexPath.row]["logo"] as! String
        Goods.orderList = [[String: Any?]]()
        Goods.orderAmount = 0
        //TODO: Goods.storeID pring -----
        print("-----goods.store")
        print(Goods.storeId )
        print( Goods.storeName)
        
        let table = storyboard?.instantiateViewController(withIdentifier: "SelectGoods") as! SelectGoodsViewController
        show(table, sender: nil)

       
    }
    func showTutorial(_ which: String) {
        if let url = URL(string: which) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
 
}

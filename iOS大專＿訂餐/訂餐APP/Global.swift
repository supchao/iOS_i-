//
//  Global.swift
//  20180604_app1
//
//  Created by Ju hua Tsai on 2018/6/4.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

struct dbKeys {
    
//    static var phpURL = "http://localhost/Ordering/"
    static var phpURL = "http://220.133.159.171/Ordering/"
    static var json:[[String:Any]] = [[:]]
    static var stat = 0
    static var error = ""
    
}
struct MYKEYS {

    static var selectedId = ""
    static var selectedName = ""
}
struct Goods {
    static var badgeCount = 0
    static var storeId = ""
    static var storeName = ""
    static var storeAddress = ""
    static var storeTel = ""
    static var storeImage = ""
    static var goodsListALL =  [[String: Any?]]()
    static var collectListALL = [[String: Any?]]()
    static var tasteListALL = [[String: Any?]]()
    static var goodsList =  [[String: Any?]]()
    static var collectList = [[String: Any?]]()
    static var orderList = [[String: Any?]]()
    static var orderDetailList = [[String: Any?]]()
    static var storeList = [[String: Any?]]()
    static var tasteList = [[String: Any?]]()
    static var orderAmount = 0
    static var goodsId = ""
    static var goodsName = ""
    static var goodsImage: Data? = nil
    static var goodsTasteList = [Any]()
    static var mergeName = ""
    static var Price1: Int = 0
    static var Price2:Int = 0
    static var qty: Int = 0
    static var addPrice = 0
    static var totAmount = 0 

    static var StoreListReload = false
    
}
struct UserKey {
    static var loginType = ""
    static var loginId = ""
    static var email = ""
    static var name = ""
    static var nickname = ""
    static var mobil = ""
    static var address = ""
    static var image: Data? = nil
    
    
}
class Global: NSObject {

    static func StringToArray(_ str: String, _ _separator: Character) -> [Any] {
        let list = str.replacingOccurrences(of: " ", with: "").split(separator: _separator)
        
        return list
        
    }
    static func loadGoodsList(_ storeId: String) {
        Goods.goodsList = [[String:Any]]()
        for p in Goods.goodsListALL {
            if p["StoreID"] as! String == storeId {
                Goods.goodsList.append(p)
            }
        }
        Goods.collectList = [[String:Any]]()
        for p in Goods.collectListALL {
            if p["StoreID"] as! String == storeId {
                Goods.collectList.append(p)
            }
        }
        Goods.tasteList = [[String:Any]]()
        for p in Goods.tasteListALL {
            if p["StoreID"] as! String == storeId {
                Goods.tasteList.append(p)
            }
        }
//
//        Goods.goodsList = [[
//                            ["id": "0101", "name":"特濃愛文霜冰","price1" : "90","price2" : "", "price3" : ""],
//                            ["id": "0102","name":"輕酪芒果飲", "price1" : "65","price2" : "", "price3" : ""],
//                            ["id": "0103","name":"愛文芒果冰沙", "price1" : "65","price2" : "", "price3" : ""],
//                            ["id": "0104","name":"愛鳳青", "price1" : "65","price2" : "", "price3" : ""],
//                            ["id": "0105","name":"奇異果汁", "price1" : "65","price2" : "", "price3" : ""],
//                            ["id": "0106","name":"鮮茄梅", "price1" : "65","price2" : "", "price3" : ""]
//                            ],
//                           [
//                            ["id": "0201", "name":"招牌水果茶","price1" : "65","price2" : "", "price3" : ""],
//                            ["id": "0202", "name":"繽紛樂果茶","price1" : "65","price2" : "", "price3" : ""]
//                               ]]
//
//        Goods.collectList = ["現賣新鮮","鮮果入茶","輕鬆醋咪","品嚐原味","濃醇奶香","凍感創意","嗜覺口感"]
//
    }
    static func readLogin() {
        //讀取使用者資訊
        //設定工作目錄
       // let fm = FileManager.default
        var path = NSHomeDirectory() + "/Documents"

        
        path = NSHomeDirectory() + "/Documents/Property List.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let loginType = plist["loginType"] {
                UserKey.loginType =  loginType as! String
            }
            if let loginId = plist["loginId"] {
                UserKey.loginId =  loginId as! String
            }
            if let email = plist["email"] {
                UserKey.email =  email as! String
            }
            if let name = plist["name"] {
                UserKey.name =  name as! String
            }
            if let nickname = plist["nickname"] {
                UserKey.nickname =  nickname as! String
            }
            if let mobil = plist["mobil"] {
                UserKey.mobil =  mobil as! String
            }
            if let address = plist["address"] {
                UserKey.address =  address as! String
            }
            if let image = plist["image"] {
                UserKey.image =  image as! Data
            }
        }
    }
    static func updateLogin() {
        //更新使用者資訊
        //設定工作目錄
        let fm = FileManager.default
        var path = NSHomeDirectory() + "/Documents"
        
        
        path = NSHomeDirectory() + "/Documents/Property List.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {

            plist["loginType"] = UserKey.loginType
            plist["loginId"] = UserKey.loginId
            plist["email"] = UserKey.email
            plist["name"] = UserKey.name
            plist["nickname"] = UserKey.nickname
            plist["mobil"] = UserKey.mobil
            plist["address"] = UserKey.address
            plist["image"] = UserKey.image
            if plist.write(toFile: path, atomically: true) {
                print("使用者資訊更新成功")
                
            }
        }
    }
    static func CLLocationToAddress(_ lat:Double, _ lon:Double, completion: @escaping (_ result: String) -> Void) {

        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: lat, longitude: lon)) { (placemark, error) in
            if error != nil {
                print(error)
                
            } else {
                //the geocoder actually returns CLPlacemark objects, which contain both the coordinate and the original information that you provided.
                if let placemark = placemark?[0] {
                    //print(placemark)
                    var address = ""
                    if placemark.postalCode != nil {
                        address += placemark.postalCode! + " "
                    }
                    if placemark.locality != nil {
                        address += placemark.locality!   //city
                    }
                    if placemark.name != nil {
                        address += placemark.name!   //city
                    }
                    
                    if placemark.country != nil {
                       // address += placemark.country!
                    }
                    if placemark.thoroughfare != nil {
                      //  address += placemark.thoroughfare! + " "
                    }
                    if placemark.subThoroughfare != nil {
                       // address += placemark.subThoroughfare! + " "
                    }
                    //print(placemark)
                    //print(placemark.name)  //路＋號
                
                    //                    print("address1:", placemark.thoroughfare ?? "")
//                    print("address2:", placemark.subThoroughfare ?? "")
//                    print("city:",     placemark.locality ?? "")
//                    print("state:",    placemark.administrativeArea ?? "")
//                    print("zip code:", placemark.postalCode ?? "")
//                    print("country:",  placemark.country ?? "")
//
                    completion(address)
                    
                }
            }
        }
    }
 

}

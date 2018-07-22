//
//  DBapi.swift
//  訂餐APP
//
//  Created by Ju hua Tsai on 2018/7/10.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit

class DBapi: NSObject {
    private var stop = false
    func OrderingQuery(_ para: [String: Any], _ file: String){
        dbKeys.stat = 0
        dbKeys.error = ""
        dbKeys.json = [[String:Any]]()
        let url = URL(string: dbKeys.phpURL + file)
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        var postfields = ""
        var cnt = 0
        for (key, value) in para {
            postfields += (cnt==0 ? "":"&") + "\(key)=\(value)"
            cnt += 1
        }
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
                        let html1 = html.data(using: .utf8)
                        do{
                            dbKeys.json  = try JSONSerialization.jsonObject(with: html1!, options: .allowFragments) as! [[String:Any]]
                            dbKeys.stat = 1
                            print("dbKeys.json：\(dbKeys.json)")
                        }catch{
                            self.stop = true
                            dbKeys.error = "error"
                            print(error)
                        }
                    }else{
                        //MARK: 沒東西
                        dbKeys.stat = 1
                        print("路過")
                    }
                }
                
            })
            dataTask.resume()
        }
        
    }
    //MARK: Delegate 委派
    func OrderMain_Delegate(_ vc: OrderListViewController) {
        //vc = vc
        let q = DispatchQueue.global()
        q.async {
            while dbKeys.stat == 0 , self.stop != true  {
                sleep(1)
            }
            //async:非同步
            DispatchQueue.main.async {
                vc.DataLoadReady()
            }
        }
    }
    func OrderBodyViewController_Delegate(_ vc: OrderBodyViewController) {
        //vc = vc
        let q = DispatchQueue.global()
        q.async {
            while dbKeys.stat == 0 , self.stop != true  {
                sleep(1)
            }
            //async:非同步
            DispatchQueue.main.async {
                vc.DataLoadReady()
            }
        }
    }
    
    func StoreListView_Delegate(_ vc: StoreListViewController) {
        //vc = vc
        let q = DispatchQueue.global()
        q.async {
            while dbKeys.stat == 0 , self.stop != true  {
                sleep(1)
            }
            //async:非同步
            DispatchQueue.main.async {
                vc.DataLoadReady()
            }
        }
    }
    func LoadOrderDetailByBuyerId(){
        //依買家載入訂單明細
        Goods.orderDetailList = [[String:Any]]()
        let url = URL(string: dbKeys.phpURL + "GetOrderDetailByBuyerId.php")
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        
        let  postfields = "buyerId=\(UserKey.loginId)"
        print("buyerId=\(UserKey.loginId)")
        
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
                        let html1 = html.data(using: .utf8)
                        do{
                            Goods.orderDetailList  = try JSONSerialization.jsonObject(with: html1!, options: .allowFragments) as! [[String:Any]]
                            
                        }catch{
                            
                            print(error)
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
    func LoadGoodsList(){
        
        Goods.goodsListALL = [[String:Any]]()
        let url = URL(string: dbKeys.phpURL + "GetDBListFromSql.php")
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        let  postfields = "sql=SELECT * FROM `Commodity` where `Use` = 1 ORDER BY `StoreID`,`commodityIDByStore`, `Id`"
        
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
                        let html1 = html.data(using: .utf8)
                        do{
                            Goods.goodsListALL  = try JSONSerialization.jsonObject(with: html1!, options: .allowFragments) as! [[String:Any]]
                            
                        }catch{
                            
                            print(error)
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
    func LoadCollectList(){
        
        Goods.collectListALL = [[String:Any]]()
        let url = URL(string: dbKeys.phpURL + "GetDBListFromSql.php")
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        let  postfields = "sql=select * from CommoditySpecies"
        
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
                        let html1 = html.data(using: .utf8)
                        do{
                            Goods.collectListALL  = try JSONSerialization.jsonObject(with: html1!, options: .allowFragments) as! [[String:Any]]
                            
                        }catch{
                            
                            print(error)
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
    func LoadTasteList(){
        
        Goods.tasteListALL = [[String:Any]]()
        let url = URL(string: dbKeys.phpURL + "GetDBListFromSql.php")
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        let  postfields = "sql=select * from TasteDefinition"
        
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
                        let html1 = html.data(using: .utf8)
                        do{
                            Goods.tasteListALL  = try JSONSerialization.jsonObject(with: html1!, options: .allowFragments) as! [[String:Any]]
                            
                        }catch{
                            
                            print(error)
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
    
    
}

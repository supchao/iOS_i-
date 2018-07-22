//
//  SelectGoodsViewController.swift
//  Swift_小專
//
//  Created by Ju hua Tsai on 2018/6/13.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit

class SelectGoodsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {
    var sectionIndex: Int = 0
    var goodsList:  [[String: Any?]] = [[:]]

    @IBOutlet weak var buttonClass: UIButton!
    
    @IBAction func onClick(_ sender: UIButton) {
        let index = sender.restorationIdentifier
        sectionIndex = Int(index!)!
        //餐點類別選擇後改變按鈕顏色
        self.SpeciesSelect(sectionIndex)
        //載入類別商品
        LoadGoodsByCollect(sectionIndex)
        tableView.reloadData()
    }
    var mycell: UITableViewCell!
    func LoadGoodsByCollect(_ index: Int) {
        let CommoditySpecies = Goods.collectList[index]["CommoditySpecies"] as! String
        //
        //        goodsList = [[:]]
        //        goodsList = Goods.goodsList[sectionIndex]
        goodsList = [[String:Any]]()
        for p in Goods.goodsList {
            if p["CommoditySpecies"] as! String == CommoditySpecies {
                goodsList.append(p)
            }
        }
    }
    @IBAction func addClick(_ sender: UIButton) {
        
        var index = Int((sender.titleLabel?.text)!)
        Goods.goodsId = goodsList[index!]["Id"] as! String
        Goods.goodsName = goodsList[index!]["CommodityName"] as! String
        Goods.goodsTasteList = Global.StringToArray(goodsList[index!]["CommodityTaste"] as! String,",")
//        print((goodsList[index!]["icon"] as! String).count)
            let pic = goodsList[index!]["Icon"] as! String
             Goods.goodsImage = Data(base64Encoded: pic)
        
       
        let price1 = goodsList[index!]["Price"] as! String
//        var price2 = goodsList[index!]["price2"] as! String
//        if price2 == "" {
//            price2 = "0"
//        }
//
        
        Goods.Price1 = Int(price1)!
     //   Goods.Price2 = Int(price2)!
 

       // print(sender.titleLabel?.text)
        
        let alert = storyboard?.instantiateViewController(withIdentifier: "AddItem")
        present(alert!, animated: true, completion: nil )
        
    }

    @IBOutlet weak var collectView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
 
    //Mark: - Collecttion 第一階段對話
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //Mark: - Collecttion 第二階段對話
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Goods.collectList.count
    }
    //Mark: - Collecttion 第三階段對話
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectCell", for: indexPath)
        
        let button = cell.viewWithTag(110) as? UIButton
        button?.setTitle(Goods.collectList[indexPath.row]["CommoditySpecies"] as! String, for: .normal )
        if sectionIndex == indexPath.row {
            button?.drawCircle(UIColor.white.cgColor, UIColor(red: 226/255, green: 236/255, blue: 188/255, alpha: 1).cgColor, 20)
            
        } else {
        button?.drawCircle(UIColor(red: 226/255, green: 236/255, blue: 188/255, alpha: 1).cgColor, UIColor.white.cgColor, 20)
            
        }

        button?.restorationIdentifier = "\(indexPath.row)"

       
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sectionIndex = indexPath.row
        tableView.reloadData()
    }
    // MARK: - 表格第一階段對話
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    // MARK: 表格第二階段對話
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return goodsList.count
    }
    // MARK: 表格第三階段對話
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let logo = cell.viewWithTag(210) as! UIImageView
        let name = cell.viewWithTag(220) as! UILabel
        name.text = goodsList[indexPath.row]["CommodityName"] as! String
        //let logoID = goodsList[indexPath.row]["Icon"] as! String
        if goodsList[indexPath.row]["Icon"] as? String != nil {
            //print(storeData[indexPath.row]["logo"] as! String)
            let imageData2 = try(Data(base64Encoded: (goodsList[indexPath.row]["Icon"] as! String)))
            
            // 将Data转化成图片
            logo.image = UIImage(data: (imageData2 ?? nil)!)
        } else {
            logo.image = nil
        }
        //logo.image = UIImage(named: logoID)
        let button = cell.viewWithTag(230) as! UIButton

        button.setTitle(("\(indexPath.row)"), for: .normal)

        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //載入商家菜單
        Global.loadGoodsList(Goods.storeId)
        Goods.badgeCount = 0
//        goodsList = [[:]]
//        goodsList = Goods.goodsList[sectionIndex]
        //載入類別商品
        LoadGoodsByCollect(sectionIndex)
        showBadgeCount()
        var back = UIBarButtonItem(title: "商家列表", style: .plain , target: self, action: #selector(backAction))

        self.navigationItem.leftBarButtonItem = back
     
    }
    
    @objc func backAction() {
        let alertController = UIAlertController( title: "是否離開？", message: "是否離開？"
            , preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default) { (btn) in
             self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(okaction)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
        
        
       
    }
    func showBadgeCount() {
        let vc =  self.parent as? BuyNavigationControll
        vc?.badgeCount = Goods.badgeCount
        vc?.setUpBadgeCountAndBarButton(willShow: self)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        //離開商品選擇畫面時開啟 tabBar
        //self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        //進入商品選擇畫面時關掉 tabBar
        self.tabBarController?.tabBar.isHidden = true
        showBadgeCount()
    }
    func SpeciesSelect(_ index: Int) {
        //餐點類別選擇後改變按鈕顏色
        var i = 0
        while i < Goods.collectList.count {
            let indexPath = IndexPath(row: i, section: 0)
            collectView.deselectItem(at: indexPath, animated: true)
            if let cell = collectView.cellForItem(at: indexPath) {
                let button = cell.viewWithTag(110) as? UIButton
                if i == index {
                    button?.backgroundColor = UIColor(red: 226/255, green: 236/255, blue: 188/255, alpha: 1)
                } else {
                    button?.backgroundColor = UIColor.white
                }
                
                
            }
            i += 1
        }
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

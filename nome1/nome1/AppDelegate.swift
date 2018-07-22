//
//  AppDelegate.swift
//  nome1
//
//  Created by huang-guochao on 2018/6/28.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging
import CoreData
import FBSDKLoginKit
import FBSDKCoreKit
import CoreLocation


var LoginData: UserDefaults!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var LoginData: UserDefaults!
    var myLocationManager: CLLocationManager!
    var myUserDefaults: UserDefaults!
    //  AppDelegate.m
    //App載入時執行
     var orderingData = DBapi()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.LoginData = UserDefaults.standard
//
        if self.LoginData.string(forKey: "phonenum") != "",self.LoginData.string(forKey: "passwd") != "",self.LoginData.string(forKey: "phonenum") != nil{
            print("phonenu = \(self.LoginData.string(forKey: "phonenum"))")
            
            let account = LoginData.string(forKey: "phonenum") as! String
////            let passwd = LoginData.string(forKey: "passwd") as! String
            let storyboard = window?.rootViewController?.storyboard
            let upidupdata:Bool = pushidupdata.idup(account)
            let togo = storyboard?.instantiateViewController(withIdentifier: "winner") as! UITabBarController
            togo.selectedIndex = 0
            self.window?.rootViewController = togo
            self.window?.makeKeyAndVisible()
        }else{
            print("no more")
        }

        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.badge,.carPlay,.sound]) { (granted, error) in
            if granted{
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
         FirebaseApp.configure()
        
        
        // -------------------------------------------
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        FBSDKSettings.setAppID("2056629527997194")
        
        let fm = FileManager.default
        //取得Property List.plist路徑
        let src = Bundle.main.path(forResource: "Property List", ofType: "plist")!
        let dst = NSHomeDirectory() + "/Documents/Property List.plist"
        //檢查目的路徑的 Property List.plist 檔案是否存在, 如果不存在則複製檔案
        if !fm.fileExists(atPath: dst) {
            try! fm.copyItem(atPath: src, toPath: dst)
            
        }
        Global.readLogin()
        
        //載入商品及類別資訊
        orderingData.LoadGoodsList()
        orderingData.LoadCollectList()
        orderingData.LoadTasteList()
        //載入訂單明細
        orderingData.LoadOrderDetailByBuyerId()
        sleep(1)
        
        // 取得儲存的預設資料
        self.myUserDefaults = UserDefaults.standard
        
        // 建立一個 CLLocationManager
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        
        
        // 首次使用 向使用者詢問定位自身位置權限
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // 取得定位服務授權
            //myLocationManager.requestWhenInUseAuthorization()
            /* 如果要調用 requestAlwaysAuthorization() 這個方法
             * 你必須在 Info.plist 當中加入 NSLocationAlwaysUsageDescription 這個 Key&Value
             * 說明為何要取得永遠授權的文字，這樣才能調用這個方法來取得 GPS 權限。
             */
            myLocationManager.requestAlwaysAuthorization()
            
            /* 如果要調用 requestWhenInUseAuthorization() 這個方法
             * 你必須在 Info.plist 當中加入 NSLocationWhenInUseUsageDescription 這個 Key&Value
             * 說明為何要取得使用 App 期間授權的文字，這樣才能調用這個方法來取得 GPS 權限。
             */
            myLocationManager.requestWhenInUseAuthorization()
            // 設定後的動作請至委任方法
            // func locationManager(
            //   manager: CLLocationManager,
            //   didChangeAuthorizationStatus status: CLAuthorizationStatus)
            // 設置
        } else if (CLLocationManager.authorizationStatus() == .denied) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(false, forKey: "locationAuth")
            
            self.myUserDefaults.synchronize()
        } else if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(true, forKey: "locationAuth")
            
            self.myUserDefaults.set(0.0, forKey: "RecordLatitude")
            self.myUserDefaults.set(0.0, forKey: "RecordLongitude")
            
            self.myUserDefaults.synchronize()
        }
        
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            // 提示可至[設定]中開啟權限
            let alertController = UIAlertController( title: "定位服務已關閉", message: "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            // 設置定位權限的紀錄
            self.myUserDefaults.set(false, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        } else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(true, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        }
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let result = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        return result
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        return result
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0)}.joined()
        print("token\(token)")
        self.LoginData.set(token, forKey: "token")
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


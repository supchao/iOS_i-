//
//  DMDataBase.swift
//  20180604_app1
//
//  Created by Ju hua Tsai on 2018/6/4.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit
import SQLite3

class DMDataBase: NSObject {
    private static var _instance: DMDataBase? = nil
    private static var _db: OpaquePointer? = nil
    static var shared: DMDataBase {
        get {
            if _instance == nil {
                _instance = DMDataBase()
                
                if let dst = _instance!.copyToSnedboxDocuments(){
                    sqlite3_open(dst, &_db)
                }
            }
            return _instance!
        }
    }
    func copyToSnedboxDocuments() ->String? {
        let fm = FileManager.default
        //取得Property List.plist路徑
        let src = Bundle.main.path(forResource: "mydb", ofType: "sqlite")!
        let dst = NSHomeDirectory() + "/Documents/mydb.sqlite"
        //檢查目的路徑的 Property List.plist 檔案是否存在, 如果不存在則複製檔案
        if !fm.fileExists(atPath: dst) {
            try! fm.copyItem(atPath: src, toPath: dst)
            
        }
        if sqlite3_open(dst, &DMDataBase._db) == SQLITE_OK {
            print("資料庫開啟成功")
            return dst
        } else
        {
            print("資料庫開啟失敗")
            return nil
        }
    }
    func 插入資料() {
        let iid = "a04".cString(using: .utf8)
        let cname = "李大媽".cString(using: .utf8)
        let sql = "insert into UserData values (?,?,null)"
        //用來儲存查詢結果
        var statement: OpaquePointer? = nil
        if sqlite3_prepare(DMDataBase._db, sql, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(DMDataBase._db))
            print("prepare error: \(errmsg)")
        }
        if sqlite3_bind_text(statement, 1, iid, -1, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(DMDataBase._db))
            print("bind error: \(errmsg)")
        }
        if sqlite3_bind_text(statement, 2, cname, -1, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(DMDataBase._db))
            print("bind error: \(errmsg)")
        }
        if sqlite3_step(statement) == SQLITE_DONE {
            print("資料插入成功")
        } else {
            
            let errmsg = String(cString: sqlite3_errmsg(DMDataBase._db))
            print("bind error: \(errmsg)")
        }
        sqlite3_finalize(statement)
    }
    func 讀出資料() -> [String] {
        // 拿著_db去執行 sql command
        if DMDataBase._db != nil {
            let tmp = "李大媽".cString(using: .utf8)
            let sql = "select * from UserData where cname = ? "
            //用來儲存查詢結果
            var statement: OpaquePointer? = nil
            if sqlite3_prepare(DMDataBase._db, sql, -1, &statement, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(DMDataBase._db))
                print("prepare error: \(errmsg)")
            }
            if sqlite3_bind_text(statement, 1, tmp, -1, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(DMDataBase._db))
                print("bind error: \(errmsg)")
            }
            //利用迴圈讀取查詢結果
            while sqlite3_step(statement) == SQLITE_ROW {
                let iid = sqlite3_column_text(statement, 0)
                let cname = sqlite3_column_text(statement, 1)
                if iid != nil {
                    let iids = String(cString: iid!)
                    print("帳號＝\(iids)")
                }
                if cname != nil {
                    let cnames = String(cString: cname!)
                    print("姓名＝\(cnames)")
                }
            }
            sqlite3_finalize(statement)
        }
        return []
    }
//    fun  c open(_ path:String) {
//        sqlite3_open(path, &_db)
//    }
}

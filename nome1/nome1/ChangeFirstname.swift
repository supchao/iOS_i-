//
//  ChangeFirstname.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/3.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class ChangeFirstname: UIViewController {
    var first:String = ""
    var json :[[String:Any]]=[[:]]
    var phonenum :String = ""
    @IBOutlet weak var firstname: UITextField!
    @IBAction func Upfirstname(_ sender: Any) {
        if firstname.text != "" {
            let fname = firstname.text!
        
        let url = URL(string: "http://220.133.159.171/Ordering/update_name.php")
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        
        request.httpBody = "mobile=\(phonenum)&name=\(fname)".data(using: .utf8)
        request.httpMethod = "POST"
        
        //MARK: URLSession 建立
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        //MARK: request
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                let html = String(data:data,encoding:.utf8)
                if html! == "1" {
                    //MARK: 更改成功
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }else{
                    print("sql error")
                }
            }
        })
        dataTask.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       json = PersonView.json
        for i in PersonView.json{
            first = i["name"] as! String
            phonenum = i["mobile"] as! String
        }
        
        firstname.text = first
        // Do any additional setup after loading the view.
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
    @IBAction func goback(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

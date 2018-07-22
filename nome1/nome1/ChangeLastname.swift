//
//  ChangeLastname.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/3.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class ChangeLastname: UIViewController {
    var last:String = ""
    var json :[[String:Any]]=[[:]]
    var phonenum :String = ""
    @IBOutlet weak var Lastname: UITextField!
    @IBAction func uplastname(_ sender: Any) {
        if Lastname.text != "" {
            let fname = Lastname.text!
            
            let url = URL(string: "http://220.133.159.171/Ordering/update_nickname.php")
            var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
            
            request.httpBody = "mobile=\(phonenum)&nickname=\(fname)".data(using: .utf8)
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
                    }
                }
            })
            dataTask.resume()
    }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        json = PersonView.json
        for i in PersonView.json{
            last = i["nickname"] as! String
            phonenum = i["mobile"] as! String
        }
        Lastname.text = last
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func goback(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

//
//  PersonView.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/3.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit


class PersonView: UITableViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    static var pic:String = ""
    var LoginData:UserDefaults!
    @IBAction func haahaa(_ sender: Any) {
        let alert = storyboard?.instantiateViewController(withIdentifier: "myalert")
        present(alert!, animated: false, completion: nil)
    }
    static var json:[[String:Any]] = [[:]]
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var Imagev: UIImageView!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var passwd: UILabel!
    @IBOutlet weak var phonelabel: UILabel!
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var changeimage: UILabel!
    @IBOutlet var mytapguest: UITapGestureRecognizer!
    
    
    static var phonenum :String = ""
    var timetag = 0
    var sql = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        phonelabel.frame = emaillabel.frame
//        phone.frame = email.frame
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.haahaa(_:)))
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.haahaa(_:)))
        self.Imagev.addGestureRecognizer(tap)
        self.changeimage.addGestureRecognizer(tap1)
        self.Imagev.layer.masksToBounds = true
        self.LoginData = UserDefaults.standard
        if UserDefaults.standard.string(forKey: "phonenum") != "",UserDefaults.standard.string(forKey: "passwd") != ""{
            print("first")
           
            PersonView.phonenum = UserDefaults.standard.string(forKey: "phonenum")!
            self.timetag = sql(PersonView.phonenum,self.timetag)
            while timetag != 1 ,sql == 0{
                sleep(1)
            }
            for i in PersonView.json{
                
                if i["passwd"] != nil{
                    var j = ""
                    for _ in 0..<(i["passwd"]! as! String).count{
                        j += "●"
                    }
                    passwd.text = j
                }
                if i["nickname"] != nil{
                    lastname.text = (i["nickname"]! as! String)}
                if i["name"] != nil{
                    firstname.text = (i["name"]! as! String)}
                if i["email"] != nil{
                    email.text = (i["email"]! as! String)}
                if i["mobile"] != nil{
                    phone.text = (i["mobile"]! as! String)}
                if i["image"] as! String != ""{
                    PersonView.pic = i["image"] as! String
                    let imagedata = Data(base64Encoded: PersonView.pic)
                    Imagev.image = UIImage(data: imagedata!)
                    print(type(of: imagedata))
                }else{
                    Imagev.image = UIImage(named: "user")
                   
                }
            }
        }else{
            print("second")
             Imagev.image = UIImage(named: "user")
            let vc = (self.parent as! emptyviewViewController)
             vc.whiteview.constant = 0
             vc.logincon.constant = 0
            
//            let alertc = UIAlertController(title: "開始使用", message: "", preferredStyle: .alert)
//            alertc.addTextField { (textfield) in
//                textfield.addTarget(self, action: #selector(self.changeview(_:)), for: .touchDown )
//            }
//            self.present(alertc,animated: true,completion: nil)
//            
        }
    }
    @objc func changeview(_ textfield:UITextField){
        let vc = storyboard?.instantiateViewController(withIdentifier:"vcView") as! ViewController
        self.present(vc, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return Imagev.frame.height * 1.2
        }
        return self.view.frame.height / 12
    }
    func sql(_ phonenum:String,_ tag:Int) -> Int{
        var sqli = tag
        let url = URL(string: "http://220.133.159.171/Ordering/Logincheck6.php")
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        request.httpBody = "mobile=\(phonenum)".data(using: .utf8)
        request.httpMethod = "POST"
        //MARK: URLSession 建立
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        //MARK: request
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                let html = String(data:data,encoding:.utf8)
                if let html = html{
                    let html1 = html.data(using: .utf8)
                    do{self.sql = 1
                        PersonView.json  = try JSONSerialization.jsonObject(with: html1!, options: .allowFragments) as! [[String:Any]]
                    }catch{
                        self.sql = 0
                        print("error")
                    }
                }else{
                    //MARK: 沒東西
                    print("路過")
                }
            }
            sqli = 1
        })
        dataTask.resume()
        return sqli
    }
    func imagereload(_ sqltag:Int){
    var reloadtmp = 0
    self.sql = 0
        reloadtmp = sql(PersonView.phonenum,sqltag)
    
    while reloadtmp != 1 ,self.sql == 0{
        sleep(1)
    }
    
    print(self.timetag)
     for i in PersonView.json{
        if i["image"] as! String != ""{
                PersonView.pic = i["image"] as! String
//                print(PersonView.pic)
                var imagedata = Data(base64Encoded: PersonView.pic)
            
            print("123\(type(of: imagedata))")
            if imagedata != nil{
                
                print("456\(type(of: imagedata))")
                 Imagev.image = UIImage(data: imagedata!) 
            }else{
                print("nilnilnil")
            }
            }else{
                Imagev.image = UIImage(named: "user")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let a = cell.viewWithTag(100) as! UIImageView
//            a.image = UIImage(named: "user")
            let mask = CALayer()
            mask.frame = a.bounds
            mask.contents = UIImage(named: "icons8-filled_circle_filled")?.cgImage
            mask.contentsScale = UIScreen.main.scale
            a.layer.mask = mask
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 6{
            UserDefaults.standard.set("", forKey: "phonenum")
            UserDefaults.standard.set("", forKey: "passwd")
           
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"mainvcc") as! UIViewController
//            present(vc, animated: true, completion: nil)
            self.show(vc, sender:self)
        }
    }
    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

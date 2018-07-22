//
//  listviewtablev.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/16.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class listviewtablev: UITableViewController {
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var ysoom: UIButton!
    @IBOutlet weak var takedata: UILabel!
    @IBOutlet weak var taketime: UILabel!
    @IBOutlet weak var ydie: UIButton!
    @IBOutlet weak var typeright: NSLayoutConstraint!
    @IBOutlet weak var typeleftcon: NSLayoutConstraint!
    @IBOutlet weak var ordertime: UILabel!
    @IBOutlet weak var orderdata: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var toaddress: UILabel!
    
    @IBOutlet weak var notice: UILabel!
    var json :[[String:Any]] = [[:]]
    var noticeall:String = ""
    var addressess:String = ""
    static var die = true
    override func viewDidLoad() {
        super.viewDidLoad()
        let phonenum = UserDefaults.standard.string(forKey: "phonenum")
        json = GetUserIdViewController.getId(phonenum!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        name.text = Goods.storeName
        address.text = Goods.storeAddress
        
        if Goods.storeImage.count > 0{
            let shopimage = Data(base64Encoded: Goods.storeImage )
            image.image = UIImage(data: shopimage!)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "HH:mm"
        let data1 = formatter.string(from: Date())
        let time1 = formatter1.string(from: Date())
        orderdata.text = data1
        ordertime.text = time1
//        toaddress.text = json[0]["address"] as! String
        toaddress.text = BeforeLoginRegisterData.address
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let hei = self.view.frame.height / 3
            return hei
            
        }
        if indexPath.row == 7,listviewtablev.die == false{
            return 0
        }
        return 50
    }
    
    @IBAction func outsoom(_ sender: UIButton) {
        if listviewtablev.die == true, sender.restorationIdentifier == "soom"{
           listviewtablev.die = false
            UITableView.animate(withDuration: 0.5) {
                let btn = (sender.superview)!.frame.width
                self.typeleftcon.constant = btn / 2
                self.typeright.constant = btn/2
                self.ysoom.setTitleColor(UIColor.white, for: .normal)
                self.ydie.setTitleColor(UIColor.lightGray, for: .normal)
                
                
                let a = self.takedata.text!
                let b = self.taketime.text!
                let rangea = a.index(after: a.startIndex)..<a.endIndex
                let rangeb = b.index(after: b.startIndex)..<b.endIndex
                self.takedata.text = "送\(a[rangea])"
                self.taketime.text = "送\(b[rangeb])"
                
                self.view.layoutIfNeeded()
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    @IBAction func outdie(_ sender: UIButton) {
        if listviewtablev.die == false, sender.restorationIdentifier == "die"{
            listviewtablev.die = true
            UITableView.animate(withDuration: 0.5) {
                self.typeleftcon.constant = 0
                self.typeright.constant = 0
                self.ysoom.setTitleColor(UIColor.lightGray, for: .normal)
                self.ydie.setTitleColor(UIColor.white, for: .normal)
                
                
                let a = self.takedata.text!
                let b = self.taketime.text!
                let rangea = a.index(after: a.startIndex)..<a.endIndex
                let rangeb = b.index(after: b.startIndex)..<b.endIndex
                self.takedata.text = "取\(a[rangea])"
                self.taketime.text = "取\(b[rangeb])"
                
                
                
                 self.view.layoutIfNeeded()
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 || indexPath.row == 5{
            (self.parent as! listViewController).datatimecons.constant = 0
        }
        if indexPath.row == 6{
            let alert = UIAlertController(title: nil, message: "請輸入備註", preferredStyle: .alert)
            alert.addTextField { (textfield) in
                textfield.placeholder = "註解"
                textfield.text = self.noticeall
            }
            let yes = UIAlertAction(title: "確定", style: .destructive) { (action) in
                if let note = alert.textFields![0].text{
                    if self.noticeall.count > 0{
                        self.noticeall = note
                        self.notice.text = self.noticeall
                    }else{
                        self.noticeall = note
                        self.notice.text = self.noticeall
                    }
                }else{
                    self.noticeall = ""
                    self.notice.text = self.noticeall
                }
                
            }
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(yes)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
        }
        if indexPath.row == 7{
            let alert = UIAlertController(title: nil, message: "請輸入備註", preferredStyle: .alert)
            alert.addTextField { (textfield) in
                textfield.placeholder = "註解"
                textfield.text = self.addressess
            }
            let yes = UIAlertAction(title: "確定", style: .destructive) { (action) in
                if let note = alert.textFields![0].text{
                    if self.addressess.count > 0{
                        self.addressess = note
                        self.toaddress.text = self.addressess
                    }else{
                        self.addressess = note
                        self.toaddress.text = self.addressess
                    }
                }else{
                    self.addressess = ""
                    self.toaddress.text = self.addressess
                }
                
            }
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(yes)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
            
        }
    }
    
    
    
    
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

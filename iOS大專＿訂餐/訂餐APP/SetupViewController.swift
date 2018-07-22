//
//  SetupViewController.swift
//  Swift_小專
//
//  Created by Ju hua Tsai on 2018/6/12.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class SetupViewController: UIViewController {
    @IBAction func testOnclick(_ sender: Any) {
        testButton.drawCircle(UIColor.white.cgColor, UIColor.red.cgColor, 20)
    }
    
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var testOnclick: UIButton!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var email: UILabel!
    @IBAction func fbLogin(_ sender: Any) {
        let fbLoginManager = FBSDKLoginManager()

        fbLoginManager.logIn(withReadPermissions: ["public_profile","email"], from: self, handler: { action, previewViewController in
            if action != nil {
                if let cancel = action?.isCancelled {
                    let tokenInfo = action?.token
                    let uid = tokenInfo?.userID
                    let tokenString = tokenInfo?.tokenString

                    if !cancel {
                        print("登入成功")
                        print("uid=\(uid)")
                        print("tokenString=\(tokenString)")
                        self.getEmail()
                    }
                }
            } else {
                print("未知的錯誤")
            }
        })
    }
    func getEmail() {
        let requestMe:FBSDKGraphRequest = FBSDKGraphRequest.init(graphPath: "/me", parameters: ["fields": "id,email, first_name, last_name, gender, picture"])
   
        let connection : FBSDKGraphRequestConnection = FBSDKGraphRequestConnection()
        connection.add(requestMe, completionHandler: { (con, results, error) in
            //access_token
            if ((error) == nil)
            {
               // var userID = result.valueForKey("id") as! NSString
                let dic = results as! NSDictionary
                let email = (dic.value(forKey: "email")!)
                let facebookId = (dic.value(forKey: "id")!)
                let first_name = (dic.value(forKey: "first_name")!)
                let last_name = (dic.value(forKey: "last_name")!)
                let url = URL(string: "https://graph.facebook.com/\(facebookId)/picture?type=large&return_ssl_resources=1")
                self.imageView.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)

                UserKey.loginType = "fb"
                UserKey.loginId = facebookId as! String
                UserKey.email = email as! String
                UserKey.name = "\(first_name), \(last_name) "
                UserKey.nickname = first_name as! String
                UserKey.image = NSData(contentsOf: url! as URL)! as Data
                Global.updateLogin()
                
            }
            else
            {
                print(error)
            }
        })
      connection.start() 
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        name.text = UserKey.name
        email.text = UserKey.email
        self.imageView.image = UIImage(data: UserKey.image!)
        self.imageView?.layer.cornerRadius = (self.imageView?.frame.height)!/2
        self.imageView?.layer.masksToBounds = true
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100,y: 100), radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        

        testButton.drawCircle(UIColor.red.cgColor,UIColor.white.cgColor, 20 )
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

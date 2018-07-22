//
//  listviewDatapicker.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/14.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class listviewDatapicker: UIViewController {
    @IBOutlet weak var datatimepicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        datatimepicker.minimumDate = Date()
    }
    @IBAction func submit(_ sender: Any) {
        let datatime = datatimepicker.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "HH:mm"
        let data1 = formatter.string(from: datatime)
        let time1 = formatter1.string(from: datatime)
        print(time1)
        ((self.parent as! listViewController).view.viewWithTag(250)?.viewWithTag(260) as! UILabel).text = data1
        ((self.parent as! listViewController).view.viewWithTag(250)?.viewWithTag(400) as! UILabel).text = time1
      
         (self.parent as! listViewController).datatimecons.constant = -300
        
    }
    @IBAction func cancel(_ sender: Any) {
        (self.parent as! listViewController).datatimecons.constant = -300
        
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

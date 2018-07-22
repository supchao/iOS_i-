//
//  myalert.swift
//  nome1
//
//  Created by huang-guochao on 2018/7/4.
//  Copyright © 2018年 huang-guochao. All rights reserved.
//

import UIKit

class myalert: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    var vc = PersonView()
    var camerakey:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func dism(_ sender: Any) {
         dismiss(animated: false,completion: nil)
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func camera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            camerakey = true
            let imagagePicker = UIImagePickerController()
            imagagePicker.sourceType = .camera
            imagagePicker.delegate = self
            print("camerakey2\(camerakey)")
            show(imagagePicker, sender: self)
        }
    }
    
    @IBAction func picture(_ sender: Any) {
       let imagepicker = UIImagePickerController()
        imagepicker.sourceType = .photoLibrary
        imagepicker.delegate = self
        
        imagepicker.modalPresentationStyle = .fullScreen
        show(imagepicker, sender: self) 
    }
    var json :[[String:Any]]=[[:]]
    var aid :String = ""
    var sql = 0
    var tag = false
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if camerakey == true{
            camerakey = false
            print("camerakey1\(camerakey)")
        }
        dismiss(animated: false, completion: nil)
        dismiss(animated: false,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        //取圖片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //壓縮
//        let reimage = resizeImage(originalImg: image)
        //存擋
        if camerakey == true{
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        //變更格式
//        let imagedata = UIImagePNGRepresentation(image)
        let imagedata = UIImageJPEGRepresentation(image, 0)
        //更改 特殊字元
        let data = imagedata?.base64EncodedString(options: .endLineWithLineFeed).addingPercentEncoding(withAllowedCharacters: .alphanumerics)
       
        
        //------------------------------------------
        
        json = PersonView.json
        for i in PersonView.json{
            
            aid = i["loginId"] as! String
        }
        print(type(of: aid))
        let url = URL(string: "http://220.133.159.171/Ordering/update_image.php")
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        print("aid\(aid)")
        
        //去掉option
        let datastr = data as! String
        print("many\(datastr.count)")
       
        request.httpBody = "image=\(datastr)&loginId=\(aid)".data(using: .utf8)
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
                    print("success")
                    self.sql = 1
                }else{
                    print("error")
                    self.sql = 0
                }
            }
            self.tag = true
        })
        dataTask.resume()
        while sql == 0 ,tag != true{
            sleep(1)
        }
        camerakey = false
        print("camerakey3\(camerakey)")
        let vcc = presentingViewController?.childViewControllers[2].childViewControllers[0] as! PersonView
        vcc.imagereload(0)
        
        
//        view.viewWithTag(500) as! PersonView
        
        
       
//        vc.imagereload()
        dismiss(animated: false, completion: nil)
        dismiss(animated: false,completion: nil)
        //------------------------------------------
       
        
    }
 
    
    //MARK: 壓縮圖片 來源 ： 網路
    private func resizeImage(originalImg:UIImage) -> UIImage{
        
        //prepare constants
        let width = originalImg.size.width
        let height = originalImg.size.height
        let scale = width/height
        
        var sizeChange = CGSize()
        
        if width <= 1280 && height <= 1280{ //a，图片宽或者高均小于或等于1280时图片尺寸保持不变，不改变图片大小
            return originalImg
        }else if width > 1280 || height > 1280 {//b,宽或者高大于1280，但是图片宽度高度比小于或等于2，则将图片宽或者高取大的等比压缩至1280
            
            if scale <= 2 && scale >= 1 {
                let changedWidth:CGFloat = 1280
                let changedheight:CGFloat = changedWidth / scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
                
            }else if scale >= 0.5 && scale <= 1 {
                
                let changedheight:CGFloat = 1280
                let changedWidth:CGFloat = changedheight * scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
                
            }else if width > 1280 && height > 1280 {//宽以及高均大于1280，但是图片宽高比大于2时，则宽或者高取小的等比压缩至1280
                
                if scale > 2 {//高的值比较小
                    
                    let changedheight:CGFloat = 1280
                    let changedWidth:CGFloat = changedheight * scale
                    sizeChange = CGSize(width: changedWidth, height: changedheight)
                    
                }else if scale < 0.5{//宽的值比较小
                    
                    let changedWidth:CGFloat = 1280
                    let changedheight:CGFloat = changedWidth / scale
                    sizeChange = CGSize(width: changedWidth, height: changedheight)
                    
                }
            }else {//d, 宽或者高，只有一个大于1280，并且宽高比超过2，不改变图片大小
                return originalImg
            }
        }
        
        UIGraphicsBeginImageContext(sizeChange)
        
        //draw resized image on Context
        originalImg.draw(in: CGRect(x:0, y:0, width:sizeChange.width, height:sizeChange.height))
        //        originalImg.draw(in: CGRect(x: 0, y: 0, width: width , height: height))
        
        //create UIImage
        let resizedImg = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImg!
        
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

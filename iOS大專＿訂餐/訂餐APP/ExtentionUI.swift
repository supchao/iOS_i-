//
//  ExtentionUI.swift
//  Swift_小專
//
//  Created by Ju hua Tsai on 2018/6/13.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit
import Foundation


extension UIButton {


    func 設定邊線顏色 (_ color:CGColor) {
        layer.borderColor = color
        layer.borderWidth = 0.5
        layer.frame = CGRect(x: frame.origin.x - 10, y: frame.origin.y - 10 , width: frame.width + 20 , height: frame.height + 20)
}
    func drawCircle (_ color:CGColor, _ bgcolor:CGColor, _ cornerRadius:CGFloat) {
        layer.backgroundColor = bgcolor
        layer.borderColor = color
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 0.5
        layer.frame = CGRect(x: frame.origin.x - 10, y: frame.origin.y - 10 , width: frame.width + 20 , height: frame.height + 20)
        layer.masksToBounds = true
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

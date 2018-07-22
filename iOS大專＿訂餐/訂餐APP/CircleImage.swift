//
//  CircleImage.swift
//  Swift_小專
//
//  Created by Ju hua Tsai on 2018/6/15.
//  Copyright © 2018年 Debbie Tsai. All rights reserved.
//

import UIKit

class CircleImage: UIImage {
    let adLayer = CATextLayer()
    override func  awakeFromNib() {
        //ex:某個元件的 座標：x:50 y:50  width: 200 height: 100
        //adLayer.frame = bounds   //frame: 50,50,200,100 bonuds = 內部元件座標(0,0,200,100)
        //adLayer.frame = CGRect(x: 0, y: 0, width: .size.width, height: bounds.size.height)

        adLayer.cornerRadius = 100
        adLayer.shadowOpacity = 0.5
        adLayer.shadowRadius = 5.0
        
        adLayer.alignmentMode = kCAAlignmentJustified   //左右對齊
        adLayer.contentsScale = UIScreen.main.scale   //照螢幕解析度給值,不然解析度不足字會糊掉

    }
}

//
//  Mysegmented.swift
//  小專題
//
//  Created by 陳金車 on 2018/6/12.
//  Copyright © 2018年 陳金車. All rights reserved.
//

import UIKit

class Mysegmented: UISegmentedControl {
    override func awakeFromNib() {
        layer.cornerRadius = 3
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 0.5
        self.tintColor = UIColor.orange
    
        self.layer.masksToBounds = true
        
        self.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.gray],for: .normal)
        self.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white],for:UIControlState.selected)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

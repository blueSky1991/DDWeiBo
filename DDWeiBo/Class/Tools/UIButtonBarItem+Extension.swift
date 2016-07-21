//
//  UIButtonBarItem+Extension.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/21.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName:String,target:AnyObject?,action:Selector) {
        
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage.init(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        self.init(customView:btn)
    }
    
}
//
//  UIButton+Extension.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/13.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

extension  UIButton {
    
    /*
     如果构造方法前面没有convenience单词, 代表着是一个初始化构造方法(指定构造方法)
     如果构造方法前面有convenience单词, 代表着是一个便利构造方法
     指定构造方法和便利构造方法的区别
     指定构造方法中必须对所有的属性进行初始化
     便利构造方法中不用对所有的属性进行初始, "因为便利构造方法依赖于指定构造方法"
     一般情况下如果想给系统的类提供一个快速创建的方法, 就自定义一个便利构造方法
     */

    convenience init(imageName:String,  backgroundimageName:String) {
                self.init()
                setImage(UIImage.init(named: imageName), forState: UIControlState.Normal)
                setImage(UIImage.init(named:imageName + "_highlighted"), forState: UIControlState.Highlighted)
                setBackgroundImage(UIImage.init(named: backgroundimageName), forState: UIControlState.Normal)
                setBackgroundImage(UIImage.init(named: backgroundimageName + "_highlighted"), forState: UIControlState.Highlighted)
                sizeToFit()
    }
}

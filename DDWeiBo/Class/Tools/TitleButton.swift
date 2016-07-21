//
//  TitleButton.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/21.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        CreateUI()
     }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CreateUI()
    }
    /**
     创建视图
     */
    func CreateUI()  {
        setImage(UIImage.init(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        setImage(UIImage.init(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        sizeToFit()
        
    }
   
    override func setTitle(title: String?, forState state: UIControlState) {
        // ?? 用于判断前面的参数是否是nil, 如果是nil就返回??后面的数据, 如果不是nil那么??后面的语句不执行
        super.setTitle((title ?? "") + " " , forState: UIControlState.Normal)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.width)!

    }
    
}

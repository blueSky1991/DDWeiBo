//
//  VisitorViewController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/18.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class VisitorViewController: UIView {
  
    
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var turntable: UIImageView!
    
      /** 设置图标和详情文字    */
    func setupStartInfo (imageName:String , desc:String)  {
        
        self.desc.text = desc
        self.icon.image = UIImage.init(named: imageName)
        startAnimation()
    }
    //注册按钮的点击事件
    @IBAction func registClick() {
        
    }
  // 登录按钮的点击事件
    @IBAction func loginClick() {
        
    }

    /** 开启动画 */
    func startAnimation ()  {
        
        let  animation = CABasicAnimation(keyPath:"transform.rotation")
        animation.toValue = 2*M_PI
        animation.repeatCount = MAXFLOAT
        animation.repeatDuration = 5.0
        animation.removedOnCompletion = false
        self.turntable.layer.addAnimation(animation, forKey: nil)
        
    }
    
    /** 加载访客的视图 */
    func visitorView() -> VisitorViewController {
        return NSBundle.mainBundle().loadNibNamed("VisitorView", owner: nil, options: nil).last as! VisitorViewController
    }

    
    
    
    
    
    
    
    
}

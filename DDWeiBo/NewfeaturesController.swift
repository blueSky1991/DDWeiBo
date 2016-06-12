//
//  NewfeaturesController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/5/6.
//  Copyright © 2016年 张东东. All rights reserved.
//

import Foundation
import UIKit

class NewfeaturesController: UIViewController {
     var  userImgView:UIImageView?
     var  userInfo:UserLoginInfoController?
     var  welcomeLabel:UILabel?
     let screen_width  = UIScreen.mainScreen().bounds.size.width
     let screen_height  = UIScreen.mainScreen().bounds.size.height
    override  func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setupView()//假设展示完了本次更新的内容之后调用的方法
    }
    
    func setupView()  {
        self.userImgView  = UIImageView()
        self.userImgView?.frame = CGRectMake(0, 0, 100, 100)
        self.userImgView?.center = self.view.center
        self.userImgView?.image = UIImage(named: "zhangdongdong.jpeg")
        self.userImgView?.layer.cornerRadius = 50
        self.userImgView?.layer.borderWidth = 1
        self.userImgView?.layer.borderColor = UIColor.whiteColor().CGColor
        self.userImgView?.alpha = 0
        self.userImgView?.layer.masksToBounds = true
        self.view.addSubview(self.userImgView!)
        animationWithImg()
    }
    
    func animationWithImg()  {
        UIView.animateWithDuration(1.5, delay: 0.5, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.userImgView?.alpha = 1
            }) { (Bool) in
                UIView.animateWithDuration(1.5, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                    self.userImgView?.transform  = CGAffineTransformMakeTranslation(0, -120)
                }) { (Bool) in
                    UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                        self.welcomeLabel = UILabel()
                        self.welcomeLabel?.text = "欢迎回来"
                        self.welcomeLabel?.textColor = UIColor.blackColor()
                        self.welcomeLabel?.textAlignment = NSTextAlignment.Center
                        self.welcomeLabel?.font = UIFont.systemFontOfSize(20)
                        let  maxY = CGRectGetMaxY(self.userImgView!.frame)
                        self.welcomeLabel?.alpha = 0
                        self.welcomeLabel?.frame = CGRectMake((self.screen_width-100)*0.5, maxY+10, 100, 30)
                        self.view.addSubview(self.welcomeLabel!)
                    }) { (Bool) in
                        UIView.animateWithDuration(1.5, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                            self.welcomeLabel?.alpha = 1
                        }) { (Bool) in
                                     print("动画全部播放完成,自动进入首页了") //可以进入首页了
                            self.presentViewController(MainTabBarController(), animated: true, completion: { 
                                
                            })
                        }
                    }
                 }
              }
          }
}


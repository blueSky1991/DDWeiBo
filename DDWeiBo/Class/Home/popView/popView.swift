//
//  popView.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/21.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class popView: UIPresentationController {
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController:presentedViewController,presentingViewController:presentingViewController)
        
    }
    override func containerViewWillLayoutSubviews() {
        presentedView()?.frame = CGRectMake(100, 45, 200, 200)
        
        containerView?.insertSubview(coverButton, atIndex: 0)
        coverButton.addTarget(self, action: #selector(coverButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
      func coverButtonClick()  {
        DDLog(coverButtonClick)
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
     lazy   var coverButton : UIButton =  {
       () -> UIButton
        in
        let btn = UIButton()
        btn.frame = UIScreen.mainScreen().bounds
        btn.backgroundColor = UIColor.clearColor()
        return btn
    }()
    
}

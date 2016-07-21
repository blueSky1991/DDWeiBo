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
    }
    
}

//
//  FoundController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/5/6.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class FoundController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !isLogin
        {
            Visitor?.setupStartInfo("visitordiscover_image_message", desc: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
            return
        }
    }
}

//
//  MeController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/5/6.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class MeController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !isLogin
        {
            Visitor?.setupStartInfo("visitordiscover_image_profile", desc: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
            return
        }

        
    }

   

}

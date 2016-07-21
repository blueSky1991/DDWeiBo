//
//  MessageController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/5/6.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class MessageController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLogin
        {
            Visitor?.setupStartInfo("visitordiscover_image_message", desc: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
            return
        }

    }
}

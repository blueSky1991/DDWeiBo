//
//  BaseTableViewController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/18.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    var isLogin = false
    
    var Visitor:VisitorViewController!
    
    override func loadView() {
        isLogin ? super.loadView() : setUpVisitorView()
    }
  
    //MARK: -- 未登录时候的动画
        private    func setUpVisitorView() {
             self.Visitor = VisitorViewController()
             view  = self.Visitor.visitorView()
//            self.Visitor.setupStartInfo("", desc: "测试文字")
            
    }
    
}

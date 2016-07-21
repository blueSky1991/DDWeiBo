//
//  BaseTableViewController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/18.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    var isLogin = true
    
    var Visitor:VisitorViewController!
    
    override func loadView() {
        isLogin ? super.loadView() : setUpVisitorView()
    }
  
    //MARK: -- 未登录时候的动画
        private    func setUpVisitorView() {
             self.Visitor = VisitorViewController()
             self.Visitor  = self.Visitor.visitorView()
            view = self.Visitor
            self.Visitor.setupStartInfo("", desc: "descname")
    }
    
}

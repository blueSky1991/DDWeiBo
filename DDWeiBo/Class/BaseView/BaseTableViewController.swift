//
//  BaseTableViewController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/18.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    var isLogin = UserAccount.isLogin()
    
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
            
            // 2.设置代理
            self.Visitor?.login.addTarget(self, action: #selector(BaseTableViewController.loginBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.Visitor?.register.addTarget(self, action: #selector(BaseTableViewController.registerBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            // 3.添加导航条按钮
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BaseTableViewController.registerBtnClick(_:)))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BaseTableViewController.loginBtnClick(_:)))
            
    }
    
    
    /// 监听登录按钮点击
    @objc private func loginBtnClick(btn: UIButton)
    {
        // 1.创建登录界面
        let sb = UIStoryboard(name: "OAuth", bundle: nil)
        let vc = sb.instantiateInitialViewController()!
        // 2.弹出登录界面
        presentViewController(vc, animated: true, completion: nil)
    }
    /// 监听注册按钮点击
    @objc private func registerBtnClick(btn: UIButton)
    {
        DDLog("监听注册按钮点击")
    }

    
}

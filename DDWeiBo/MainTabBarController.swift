//
//  MainTabBarController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/5/6.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var HomeNavController: MainNavgationController?
    var MessageNavController: MainNavgationController?
    var FoundNavController: MainNavgationController?
    var MeNavController: MainNavgationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
     func setupView() {
        self.HomeNavController = MainNavgationController(rootViewController:HomeController())
        self.MessageNavController = MainNavgationController(rootViewController:MessageController())
        self.FoundNavController = MainNavgationController(rootViewController:FoundController())
        self.MeNavController = MainNavgationController(rootViewController:MessageController())
        self.viewControllers = [self.HomeNavController!,self.MessageNavController!,self.FoundNavController!,self.MeNavController!]
        self.selectedIndex = 0
    }
    


}

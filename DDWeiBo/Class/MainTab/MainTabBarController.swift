//
//  MainTabBarController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/5/6.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加子控制器
        addChildControllers()
        
    }
    /**
     添加子控制器
     */
    func addChildControllers() {
        tabBar.tintColor = UIColor.orangeColor()
        addChildViewControllers(HomeController(), title: "首页", imageName: "tabbar_home")
        addChildViewControllers(MessageController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewControllers(FoundController(), title: "发现", imageName: "tabbar_discover")
        addChildViewControllers(MeController(), title: "我", imageName: "tabbar_profile")
        
    }
    /**
     自定义控制器
     
     - parameter childController: 子控制器
     - parameter title:           名称
     - parameter imageName:       图片
     */
    func addChildViewControllers(childController: UIViewController ,title:String, imageName:String) {
        childController.title = title;
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named:imageName+"_highlighted" )
        
        let navContr = MainNavgationController(rootViewController: childController)
        
       addChildViewController(navContr)
    }
    
    
}

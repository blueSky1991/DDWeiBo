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
        // 根据json的名称找到相对应的路径
          guard    let filePath =    NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil) else{
            DDLog("无法找到json路径")
            return
        }
        // 转化为data类型
        let data  = NSData(contentsOfFile: filePath)
        
        //转化为字典类型
        guard let dictArray = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) else {
            tabBar.tintColor = UIColor.orangeColor()
            addChildViewControllers("HomeController", title: "首页", imageName: "tabbar_home")
            addChildViewControllers("MessageController", title: "消息", imageName: "tabbar_message_center")
            addChildViewControllers("FoundController", title: "发现", imageName: "tabbar_discover")
            addChildViewControllers("MeController", title: "我", imageName: "tabbar_profile")

           DDLog("转化为字典失败 进行默认的加载")
           return
        }
        
        // 在dictArray中遍历字典类型 as! [[String :String]]是将dictArray中的每个对象转化为字典
        for  dict  in dictArray  as! [[String :String]]{
            addChildViewControllers(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)

        }
    
    }
    /**
     自定义控制器
     
     - parameter childController: 子控制器
     - parameter title:           名称
     - parameter imageName:       图片
     */
    func addChildViewControllers(childControllerString: String ,title:String, imageName:String) {
        
        //获取命名空间
        guard let name =   NSBundle.mainBundle().infoDictionary!["CFBundleName"] as? String else {
            DDLog("获取BundleName失败")
            return;
        }
        //拼接命名空间
        let clas :AnyClass?  = NSClassFromString(name + "." + childControllerString)
        //将命名空间转化为UITableViewController类型
        guard let childControllerClas   = clas as? UITableViewController.Type else {
           DDLog("转换类型失败")
           return
        }
        //创建与字符串对应的控制器
        let childController = childControllerClas.init()
        
        //定制控制器
        childController.title = title;
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named:imageName+"_highlighted" )
        
        //加入导航控制器
        let navContr = MainNavgationController(rootViewController: childController)
        
        //加入标签控制器的子视图中
       addChildViewController(navContr)
    }
    
    
}

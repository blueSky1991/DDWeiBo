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
//        addChildControllers()
        //composeButton 添加在这里的话由于子视图为创建好,所以系统的tabBarItemButton会覆盖在创建的仕途上,点击按钮,视图接收不到事件
//        tabBar.addSubview(composeButton)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       // 在视图已经创建好并且将要显示的时候,再添加子视图会覆盖系统的按钮,这样点击按钮视图就可以接收到点击事件
        tabBar.addSubview(composeButton)

        // composeButton 更改视图的尺寸
        let rect = composeButton.frame
        let width = tabBar.bounds.size.width/CGFloat(childViewControllers.count)
        composeButton.frame = CGRectMake(2*width, 0, width, rect.height)
        
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
        guard  let data  = NSData(contentsOfFile: filePath) else {
            DDLog("转化为data类型 ")
           return
        }
        
        //转化为字典类型
        guard let dictArray = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [[String: AnyObject]] else {
            tabBar.tintColor = UIColor.orangeColor()
            addChildViewControllers("HomeController", title: "首页", imageName: "tabbar_home")
            addChildViewControllers("MessageController", title: "消息", imageName: "tabbar_message_center")
            addChildViewControllers("NullViewController", title:"", imageName: "")
            addChildViewControllers("FoundController", title: "发现", imageName: "tabbar_discover")
            addChildViewControllers("MeController", title: "我", imageName: "tabbar_profile")

           DDLog("转化为字典失败 进行默认的加载")
           return
        }
        
        // 在dictArray中遍历字典类型 as! [[String :String]]是将dictArray中的每个对象转化为字典
        for  dict  in dictArray  {
            addChildViewControllers(dict["vcName"]! as! String, title: dict["title"]! as! String, imageName: dict["imageName"]! as! String)

        }
    
    }
    /**
     自定义控制器
     
     - parameter childController: 子控制器字符串
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
    
    
    /**
     composeButton点击事件
     
     - parameter btn: 被点击的按钮
     */
    func composeButtonDidClick(btn:UIButton)  {
        DDLog("composeButtonDidClick")
    }
    
    
    
    // 懒加载
    lazy var composeButton:UIButton={
       ()->UIButton
        in
        let btn = UIButton(imageName:"tabbar_compose_icon_add", backgroundimageName: "tabbar_compose_button")
        btn.addTarget(self, action: #selector(MainTabBarController.composeButtonDidClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
}

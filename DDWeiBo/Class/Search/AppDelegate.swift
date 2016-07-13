//
//  AppDelegate.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/5/6.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit
import QorumLogs

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainTabBar:MainTabBarController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow()
        self.window?.frame = UIScreen.mainScreen().bounds
        self.window?.backgroundColor = UIColor.whiteColor()
//        let   user  = NSUserDefaults.standardUserDefaults()
//        let    isFirstInstall =   user .objectForKey("zhangdongdong")?.boolValue
//        if isFirstInstall == true {//调试阶段，每次先进入到 新特性界面
//            self.window?.rootViewController = NewfeaturesController()
//        }else{//暂时进不去
           self.window?.rootViewController = MainTabBarController()
//        }
//        user .setBool(true, forKey: "zhangdongdong")
//        user.synchronize()
        self.window?.makeKeyAndVisible()
        return true
    }

}

func DDLog<T>(message:T ,fileName : String = #file, methodName : String = #function, lineNum:Int64 = #line){
    #if DEBUG
     print("\((fileName as NSString).pathComponents.last!):\(lineNum)\(methodName):\(message)")
    #endif
}



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
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        // 一般情况下设置全局性的属性, 最好放在AppDelegate中设置, 这样可以保证后续所有的操作都是设置之后的操作
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        DDLog(UserAccount.loadUserAccount())
        
        
        return true
    }

}

func DDLog<T>(message:T ,fileName : String = #file, methodName : String = #function, lineNum:Int64 = #line){
    #if DEBUG
     print("\((fileName as NSString).pathComponents.last!): [\(lineNum)] \(methodName):\(message)")
    #endif
}



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
        
        return true
    }

}

func DDLog<T>(message:T ,fileName : String = #file, methodName : String = #function, lineNum:Int64 = #line){
    #if DEBUG
     print("\((fileName as NSString).pathComponents.last!): [\(lineNum)] \(methodName):\(message)")
    #endif
}



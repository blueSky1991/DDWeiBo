//
//  String+Extension.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/26.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

extension   String {

    /**
     保存到沙盒documents的目录
     */
    func documents()->String  {
        // 1.获取目录的路径
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let name = (self as NSString).lastPathComponent
        // 2.生成路径
         return  (path as NSString).stringByAppendingPathComponent(name)
    }
    /**
     保存到沙盒Caches的目录
     */
    func caches() ->String {
        
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let name = (self as NSString).lastPathComponent
        // 2.生成路径
        return  (path as NSString).stringByAppendingPathComponent(name)

    }
    /**
     保存到沙盒tmp的目录
     */
    func tmp() ->String {
        // 1.获取的路径
        let path = NSTemporaryDirectory()
        let name = (self as NSString).lastPathComponent
        // 2.生成路径
        return  (path as NSString).stringByAppendingPathComponent(name)
    }

}

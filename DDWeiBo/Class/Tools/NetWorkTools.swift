//
//  NetWorkTools.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/26.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit
import AFNetworking

class NetWorkTools: AFHTTPSessionManager {

    static let shareInstance: NetWorkTools = {
        
        let baseUrl = NSURL(string:"https://api.weibo.com/")
        
        let instance = NetWorkTools.init(baseURL: baseUrl, sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
    instance.responseSerializer.acceptableContentTypes = NSSet(object: "text/plain") as? Set
    
      return instance
    }()

}

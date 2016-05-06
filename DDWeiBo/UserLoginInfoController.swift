//
//  UserLoginInfoController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/5/6.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class UserLoginInfoController: NSObject {
    /**  用户名  */
    var userName:String?
    /**  密码  */
    var passWord:String?
    /**
     将登陆者的信息写入沙盒
     */
    func saveInfoToSanBox(userName:String,passWord:String)  {
        self.userName = userName
        self.passWord = passWord
        let user = NSUserDefaults.standardUserDefaults()
        user .setObject(userName, forKey: "userName")
        user .setObject(passWord, forKey: "passWord")
        user.synchronize()
    }
    /**
     从沙盒读取用户的信息
     */
    func readInfoFromSanBox()->(NSDictionary){
        let user = NSUserDefaults.standardUserDefaults()
        self.userName = user.objectForKey("userName")?.stringValue
        self.passWord = user.objectForKey("passWord")?.stringValue
        user.synchronize()
        let  userInfoDict = NSMutableDictionary()
        userInfoDict .setValue(self.userName, forKey: "userName")
        userInfoDict .setValue(self.passWord, forKey: "passWord")
        return userInfoDict
    }

    
    
    
}

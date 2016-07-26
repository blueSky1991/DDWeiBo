//
//  UserAccount.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/26.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit
//"access_token" = "2.009XXdQE0OJTZOf66217bb43m8TdRC";
//            "expires_in" = 157679999;
//            "remind_in" = 157679999;
//            uid = 3910376422;
//
class UserAccount: NSObject,NSCoding {

    var access_token:String?
    var expires_in : Int = 0
    var uid : String?
    /**
     进行赋值
     */
    init(dict:[String:AnyObject]){
    super.init()
        self.setValuesForKeysWithDictionary(dict)
    }
    
    // 当KVC发现没有对应的key时就会调用
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        // 将模型转换为字典
        let property = ["access_token", "expires_in", "uid"]
        let dict = dictionaryWithValuesForKeys(property)
        // 将字典转换为字符串
        return "\(dict)"
    }
    
    // MARK: - 外部控制方法
    // 归档模型
     func saveAccount() -> Bool{
    
       DDLog("保存成功")
        return NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath)
    }
    /// 定义属性保存授权模型
    static var account: UserAccount?
       static let filePath: String = "useraccount.plist".documents()
    // 归档模型
    class   func loadUserAccount() -> UserAccount?{
        //0 判断用户的信息是否存在,不存在的时候再去加载,有直接返回
        if UserAccount.account != nil {
            
            DDLog("已经加载过")
            return UserAccount.account
        }
        
        
        DDLog("正在加载")
        
        guard   let account =   NSKeyedUnarchiver.unarchiveObjectWithFile(UserAccount.filePath) as? UserAccount  else {
        return UserAccount.account
        }
        // 将得到的数据赋值
        UserAccount.account = account
        
        return UserAccount.account
    }

  //  判断用户是否登录
    class func isLogin() -> Bool {
        return UserAccount.loadUserAccount() != nil
    }

    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeInteger(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.access_token = aDecoder.decodeObjectForKey("access_token") as? String
        self.expires_in = aDecoder.decodeIntegerForKey("expires_in") as Int
        self.uid = aDecoder.decodeObjectForKey("uid") as? String
    }
    
}

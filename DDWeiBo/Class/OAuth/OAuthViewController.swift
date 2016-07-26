//
//  OAuthViewController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/26.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {
    /// 容器视图
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.定义字符串保存登录界面URL
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(DDWeiBo_AppKey)&redirect_uri=\(DDWeiBo_Redirect_uri)"
        guard   let url = NSURL(string: urlStr) else {
            
         return
        }
        let request = NSURLRequest.init(URL: url)
        webView.loadRequest(request)
    }


}

//MARK:-UIWebViewDelegate
extension OAuthViewController:UIWebViewDelegate{
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
    //http://www.baidu.com/?code=81d084a26a83a6939ca46fc7ce3489a1
        // 1.判断当前是否是授权回调页面
        //完整的url字符串
        guard let urlStr = request.URL?.absoluteString else
        {
            return false
        }
        if !urlStr.hasPrefix(DDWeiBo_Redirect_uri)
        {
            DDLog("不是授权回调页面")
            return true
        }
        
        DDLog("是授权回调页面")

        // 2.判断授权回调地址中是否包含code=
        // URL的query属性是专门用于获取URL中的参数的, 可以获取URL中?后面的所有内容
        let key = "code="
        guard let str = request.URL!.query else
        {
            return false
        }
        
        if str.hasPrefix(key)
        {
            let code = str.substringFromIndex(key.endIndex)
            loadAccessToken(code)
            return false
        }
        DDLog("授权失败")
        return false
    }
    
    /// 利用RequestToken换取AccessToken
    private func loadAccessToken(codeStr: String?){
    
        guard let token = codeStr else {
            
        return
        }
        
        let parameters = ["client_id": DDWeiBo_AppKey, "client_secret": DDWeiBo_AppSecret, "grant_type": "authorization_code", "code": token, "redirect_uri": DDWeiBo_Redirect_uri]
        
        NetWorkTools.shareInstance.POST(OAuth_access_Token, parameters: parameters, success: { (task:NSURLSessionDataTask, dict:AnyObject?) in
            
          let account =  UserAccount.init(dict: dict  as! [String : AnyObject] )
            account.saveAccount()
            
                  }) { (task:NSURLSessionDataTask?, error:NSError) in
                    
             DDLog(error)
        }
    
    }

    
}




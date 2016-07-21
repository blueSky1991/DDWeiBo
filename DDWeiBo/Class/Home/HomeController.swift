//
//  HomeController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/5/6.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class HomeController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !isLogin{
            Visitor?.setupStartInfo("visitordiscover_feed_image_house", desc: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        setNavitems()
    }
    
    func setNavitems()  {
        // 设置导航栏左右两边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention",target: self,action:#selector(leftButtonClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop",target: self,action:#selector(rightButtonClick))
        
        // 设置导航栏中间的视图
        let titleView = TitleButton()
        titleView.setTitle("DDWeiBo", forState: UIControlState.Normal)
        titleView.addTarget(self, action: #selector(titleViewClick), forControlEvents: UIControlEvents.TouchUpInside)
        titleView.sizeToFit()
        navigationItem.titleView = titleView
        

        
    }
    
    @objc private func  titleViewClick(btn:TitleButton){

         DDLog(titleViewClick)
        btn.selected = !btn.selected
        
        //创建pop视图
        let sb = UIStoryboard.init(name: "popView", bundle: nil)
        guard let menuView = sb.instantiateInitialViewController() else{
            
            return
        }
        menuView.transitioningDelegate = self
        menuView.modalPresentationStyle = UIModalPresentationStyle.Custom
        presentViewController(menuView, animated: true, completion: nil)
        
    }

       @objc private  func leftButtonClick()  {
        DDLog(leftButtonClick)
    }

    @objc private  func rightButtonClick()  {
        DDLog(rightButtonClick)
    }
}

extension HomeController:UIViewControllerTransitioningDelegate{

    // 该方法用于返回一个负责转场动画的对象
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return popView(presentedViewController: presented, presentingViewController: presenting)
    }

}


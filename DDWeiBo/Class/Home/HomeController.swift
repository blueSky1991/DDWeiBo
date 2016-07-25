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
        let sb = UIStoryboard(name: "QRCode", bundle: nil)
        let vc = sb.instantiateInitialViewController()!
       presentViewController(vc, animated: true, completion: nil)
    }
}


/// 定义标记记录当前是否是展现
private var isPresent = false

extension HomeController:UIViewControllerTransitioningDelegate{

    // 该方法用于返回一个负责转场动画的对象
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return popView(presentedViewController: presented, presentingViewController: presenting)
    }
    
    
    // 该方法用于返回一个负责转场如何出现的对象
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = true
        return self
    }
    
    // 该方法用于返回一个负责转场如何消失的对象
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = false
        return self
    }
    
}


extension HomeController: UIViewControllerAnimatedTransitioning
{
    // 告诉系统展现和消失的动画时长
    // 暂时用不上
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return 0.5
    }
    
    // 专门用于管理modal如何展现和消失的, 无论是展现还是消失都会调用该方法
    /*
     注意点: 只要我们实现了这个代理方法, 那么系统就不会再有默认的动画了
     也就是说默认的modal从下至上的移动系统不帮再帮我们添加了, 所有的动画操作都需要我们自己实现, 包括需要展现的视图也需要我们自己添加到容器视图上(containerView)
     */
    // transitionContext: 所有动画需要的东西都保存在上下文中, 换而言之就是可以通过transitionContext获取到我们想要的东西
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        // 0.判断当前是展现还是消失
        if isPresent
        {
            // 展现
            // 1.获取需要弹出视图
            // 代表的是需要添加动画的视图
//            transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            
            // 代表的是动画是从哪个控制器出来的
            //transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
          
            
            // 通过ToViewKey取出的就是toVC对应的view
            guard let toView = transitionContext.viewForKey(UITransitionContextToViewKey) else
            {
                return
            }
            
            // 2.将需要弹出的视图添加到containerView上
            transitionContext.containerView()?.addSubview(toView)
            
            // 3.执行动画
            toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
            // 设置锚点
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                toView.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                // 注意: 自定转场动画, 在执行完动画之后一定要告诉系统动画执行完毕了
                transitionContext.completeTransition(true)
            }
            
        }else
        {
            // 消失
            // 1.拿到需要消失的视图
            guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) else
            {
                return
            }
            // 2.执行动画让视图消失
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                // 突然消失的原因: CGFloat不准确, 导致无法执行动画, 遇到这样的问题只需要将CGFloat的值设置为一个很小的值即可
                fromView.transform = CGAffineTransformMakeScale(1.0, 0.00001)
                }, completion: { (_) -> Void in
                    // 注意: 自定转场动画, 在执行完动画之后一定要告诉系统动画执行完毕了
                    transitionContext.completeTransition(true)
            })
        }
    }
}



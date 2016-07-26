//
//  QRcodeViewController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/22.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit
import AVFoundation

class QRcodeViewController: UIViewController {
    // 容器视图
    @IBOutlet weak var customContainerView: UIView!
    
    // 冲击波视图的顶部约束
    @IBOutlet weak var shockWave: NSLayoutConstraint!
    
     // 冲击波的视图
    @IBOutlet weak var qrcodeView: UIImageView!
    
    // 容器的高度
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    
    // 扫描的显示框自定义文字
    @IBOutlet weak var customeLabel: UILabel!
    
    @IBOutlet weak var customTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

       // 默认选择第一个
        customTabBar.selectedItem = customTabBar.items?.first
        
        //customTabBar  的代理
        customTabBar.delegate = self
        
        // 开启二维码的扫描
        QRcodeScan()
    }
    //MARK:- 视图将要出现
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }
    
    
    

    //MARK:- 二维码扫描
    func QRcodeScan()  {
        // 1. 判断输入能否加入到会话之中
        if !session.canAddInput(input) {
            return
        }
        // 2. 判断输出能否加入到会话之中
        if !session.canAddOutput(output) {
            return
        }
       // 3. 将输入,输出加入到会话之中
        session.addInput(input)
        session.addOutput(output)
        
        //4.设置输出类型能够解析的设置
        // 该解析设置必须在添加到会话之后才能开启
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        /// 5.设置监听输出解析到的数据
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())

        // 6.添加到预览层
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        previewLayer.frame = view.bounds
        
        // 7. 添加容器图层
        view.layer.addSublayer(containerLayer)
        containerLayer.frame = view.bounds
        
        // 8.开启二维码的扫描
        session.startRunning()
        
    }
    
    // 开始冲击波的动画
    func startAnimation()  {
        shockWave.constant = -containerHeight.constant
        view.layoutIfNeeded()
        UIView.animateWithDuration(2.0, animations: {
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.shockWave.constant = self.containerHeight.constant
            self.view.layoutIfNeeded()
        }) { (_) in
        }
        
    }
    
    // 生成自己的二维码的
    @IBAction func createMyQRcode(sender: AnyObject) {
        self.navigationController?.pushViewController(QRcreateViewController(), animated: true)

    }
    
    // 导航栏左侧关闭按钮
    @IBAction func dismissClick(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    // 导航栏右侧相册按钮
    @IBAction func photoClick(sender: AnyObject) {
     
        /**
         TypePhotoLibrary, 相册库
         TypeCamera, 相机
         TypeSavedPhotosAlbum 图片库
         */
        
        //0. 先判断是否能打开相册
          if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
        return
        }
        // 1  创建并弹出相册的控制器
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    //MARK:-懒加载
    // 输入对象
    lazy var input : AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        return try? AVCaptureDeviceInput(device: device)
    }()
    //  建立会话
    private var  session:AVCaptureSession = AVCaptureSession()
    
    //输出对象
    private lazy var output:AVCaptureMetadataOutput = {
    
        let out = AVCaptureMetadataOutput()
        
//        let viewRect = self.view.frame
//        let containRect = self.customContainerView.frame
//        let x = containRect.origin.y/viewRect.height
//        let y = containRect.origin.x/viewRect.width
//        let with = containRect.height/viewRect.height
//        let height = containRect.width/viewRect.width
//        out.rectOfInterest = CGRect(x:x,y:y,width:with,height:height)
        
    return out
    }()
    //建立预览层
   private lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    
    // 用于定位扫描的容器图层
    private lazy var containerLayer:CALayer = CALayer()
    
}
//MARK:-UIImagePickerControllerDelegate

extension QRcodeViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    // 打开相册
    func  imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
    
        DDLog(info)
        // 得到选中的图片否则返回
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        guard let ciimage = CIImage(image:image) else {
        
        return
        }
        
        // 创建探测器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode,context: nil,options:[CIDetectorAccuracy: CIDetectorAccuracyLow])
        
        // 利用探测器探取数据
     let results =  detector.featuresInImage(ciimage)
        
        // 取出数据
        for result in results {
            
            DDLog((result as! CIQRCodeFeature).messageString)
            
        }
        
        // 关闭相册,一旦此方法被实现的话,当选中图片的时候系统不会关闭相册
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }

}


//MARK:-UITabBarDelegate
extension QRcodeViewController:AVCaptureMetadataOutputObjectsDelegate{
    //只要扫描到结果就会调用的代理方法
    func   captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!){
//        DDLog( metadataObjects.last?.stringValue)
        //将扫描到的结果显示出来
       customeLabel.text = metadataObjects.last?.stringValue
        
       clearLayers()
        
        // 如果拿不到数据就返回
        guard let medata = metadataObjects.last as? AVMetadataObject else {
            return
        }
       
//        DDLog("前:\((medata as!  AVMetadataMachineReadableCodeObject).corners)")
        let objc = previewLayer.transformedMetadataObjectForMetadataObject(medata)
        
//        DDLog((objc as!  AVMetadataMachineReadableCodeObject).corners)
        
        drawLayerWithobjc(objc as! AVMetadataMachineReadableCodeObject)
        
    }
    
    /**
      绘制扫描的边框
     */
    func drawLayerWithobjc(objc:AVMetadataMachineReadableCodeObject)  {
        
        //0 进行安全的校验
        
        guard let  array = objc.corners else{
        return
        }
        
        //1.  绘制图形
        let shapLayer = CAShapeLayer()
        shapLayer.lineWidth = 2
        shapLayer.strokeColor = UIColor.greenColor().CGColor
        shapLayer.fillColor = UIColor.clearColor().CGColor
        
        //2 . 绘制贝塞尔曲线
        let path = UIBezierPath()
        var point = CGPointZero
        var index = 0
        CGPointMakeWithDictionaryRepresentation(array[index++] as! CFDictionary, &point)
        
        // 3. 将线段移动到某一个点
        path.moveToPoint(point)
        
        // 4. 将数组里面所有的点都加入到路线中
        while index < array.count {
            CGPointMakeWithDictionaryRepresentation(array[index++] as! CFDictionary, &point)
             path.addLineToPoint(point)
        }
        
        
        //5 . 闭合曲线
        path.closePath()
        
        //6 曲线赋给图层,并添加到图层上
        shapLayer.path = path.CGPath
        containerLayer.addSublayer(shapLayer)
        
    }
    
    /**
     清除子图层
     */
    func clearLayers()  {
        
        guard let subLayer = containerLayer.sublayers else{
        
            return
        }
        
        for layer in subLayer {
            layer.removeFromSuperlayer()
        }
    }
    
}

//MARK:-UITabBarDelegate
extension QRcodeViewController:UITabBarDelegate{
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem){
    DDLog(item.tag)
        self.containerHeight.constant = (item.tag == 1) ? 200 : 100
        view.layoutIfNeeded()
        qrcodeView.layer.removeAllAnimations()
        startAnimation()
    }

}




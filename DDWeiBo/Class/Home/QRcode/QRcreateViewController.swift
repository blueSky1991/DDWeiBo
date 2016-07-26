//
//  QRcreateViewController.swift
//  DDWeiBo
//
//  Created by 张东东 on 16/7/25.
//  Copyright © 2016年 张东东. All rights reserved.
//

import UIKit

class QRcreateViewController: UIViewController {

    var  codeImage:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建显示二维码的视图
        createQRcodeView()
        
        //
        createCode()
        
    }
    /**
     创建显示二维码的视图
     */
    func createQRcodeView()  {
        self.view.backgroundColor = UIColor.whiteColor()
        self.codeImage = UIImageView()
        self.codeImage!.frame = CGRectMake(100, 100, 300, 300)
        self.codeImage!.center = self.view.center
        self.view.addSubview(self.codeImage!)

    }
    
    // 创建二维码信息
    func createCode()  {
        // 设置滤镜
      let filter =  CIFilter(name: "CIQRCodeGenerator")
        //设置默认的配置
        filter?.setDefaults()
        // 设置需要生成二维码的数据到滤镜中
        // OC中要求设置的是一个二进制数据
        filter?.setValue("DDWeiBo".dataUsingEncoding(NSUTF8StringEncoding), forKeyPath: "InputMessage")
         //从滤镜中取出二维码
        guard let ciimage = filter?.outputImage else {
        return
        }

        self.codeImage?.image = createNonInterpolatedUIImageFormCIImage(ciimage, size: 300)
        
    }
    
    
    /**
     生成高清二维码
     
     - parameter image: 需要生成原始图片
     - parameter size:  生成的二维码的宽高
     */
    private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent: CGRect = CGRectIntegral(image.extent)
        let scale: CGFloat = min(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent))
        
        // 1.创建bitmap;
        let width = CGRectGetWidth(extent) * scale
        let height = CGRectGetHeight(extent) * scale
        let cs: CGColorSpaceRef = CGColorSpaceCreateDeviceGray()!
        let bitmapRef = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, cs, 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImageRef = context.createCGImage(image, fromRect: extent)
        
        CGContextSetInterpolationQuality(bitmapRef,  CGInterpolationQuality.None)
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
        // 2.保存bitmap到图片
        let scaledImage: CGImageRef = CGBitmapContextCreateImage(bitmapRef)!
        
        return UIImage(CGImage: scaledImage)
    }


}

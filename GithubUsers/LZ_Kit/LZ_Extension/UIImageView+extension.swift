//
//  UIImageView+extension.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView{

func setCornerImage(){
    //1.建立上下文
    
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)

        //获取当前上下文
        let ctx = UIGraphicsGetCurrentContext()
        
        //设置填充颜色
        UIColor.white.setFill()
        UIRectFill(self.bounds)
        
        //2.添加圆及裁切
        ctx?.addEllipse(in: self.bounds)
        //裁切
        ctx?.clip()
        
        //3.绘制图像
        self.draw(self.bounds)
        
        //4.获取绘制的图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //5关闭上下文
        UIGraphicsEndImageContext()
        
        self.image = image
}}

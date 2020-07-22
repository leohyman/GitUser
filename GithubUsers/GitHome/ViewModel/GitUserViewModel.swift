//
//  GitUserViewModel.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit
import SwiftyJSON

class GitUserViewModel: LZBaseViewModel {

    
    
    deinit {
        print("\(self)释放了");
    }
    
    private var indexPage: Int = 2
    
    override init() {
        super.init()
    }

   
    //MARK: - 请求首页数据
    func getUserData(isFirst :Bool) {
        
        if isFirst {
            self.dataArray.removeAll()
            self.indexPage = 1
        }
        
        APINetWork.request(.userList(self.indexPage), success: { [weak self] result in
            dismiss()
            if let weakSelf = self {
                let dataArray = JSON(result)
                   //解析数据
                   if let items = dataArray.arrayObject {
                       for item in items {
                           let dataDict = item as? [String : Any]
                           if let object = GitUserModel.deserialize(from: dataDict) {
                               //添加元素
                               weakSelf.dataArray.append(object)
                           }
                       }
                   }
                   //判断是否还有数据
                   
                   if dataArray.count == 0{
                       weakSelf.publishSubject.onNext(0)
                   } else
                   {
                       weakSelf.indexPage += 1
                       weakSelf.publishSubject.onNext(1)
                   }
                
            }
           
            //回调
        }, error: { [weak self] code in
           if let weakSelf = self  {
                dismiss()
                weakSelf.publishSubject.onNext(1)
            }
        }) { [weak self] (error) in
             if let weakSelf = self  {
                     
                dismiss()
                
                weakSelf.publishSubject.onNext(1)
            }
        }
    }
    
}




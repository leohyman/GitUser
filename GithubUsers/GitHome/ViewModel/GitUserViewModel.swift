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
    
    private var indexPage: Int = 1
    
    override init() {
        super.init()
    }

   
    //MARK: - 请求首页数据
    func getUserData(isFirst :Bool) {
            
        APINetWork.request(.userList(indexPage), success: { result in
            let dataArray = JSON(result)
            //解析数据
            if let items = dataArray.arrayObject {
                for item in items {
                    let dataDict = item as? [String : Any]
                    if let object = GitUserModel.deserialize(from: dataDict) {
                        //添加元素
                        self.dataArray.append(object)
                    }
                }
            }
            //判断是否还有数据
            
            if dataArray.count == 0{
                self.publishSubject.onNext(0)
            } else
            {
                self.indexPage = self.indexPage + 1
                self.publishSubject.onNext(1)
            }
            //回调
        }, error: { code in
            dismiss()
            self.publishSubject.onNext(1)
        }) { (error) in
            dismiss()
            self.publishSubject.onNext(1)
        }
    }
    
}
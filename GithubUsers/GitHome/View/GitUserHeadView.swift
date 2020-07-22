//
//  GitUserHeadView.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit

class GitUserHeadView: LZBaseView {

     var viewModel = GitUserViewModel()
      var textField = UITextField()
      override init(viewModel: LZBaseViewModel) {
          super.init(viewModel: viewModel)
          self.viewModel = viewModel as! GitUserViewModel
          setupUI()
          
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      
      //MARK: setupUI
      func setupUI()  {
        
        addSubview(textField)
        textField.placeholder = "请输入用户名"
//        self.backgroundColor = UIColor.red
    }
}

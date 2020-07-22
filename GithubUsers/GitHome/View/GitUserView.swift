//
//  GitUserView.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit

class GitUserView: LZBaseView ,UITableViewDelegate,UITableViewDataSource{
    var viewModel = GitUserViewModel()
    
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
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0);
        }
        
        let headView = UIView()
        headView.backgroundColor = UIColorFromHex(rgbValue: 0xF2F2F2)
        headView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 10)
        self.tableView.tableHeaderView = headView
    
        self.tableView.reloadData()
        
        
        
        self.viewModel.publishSubject.subscribe(onNext: { code in
            print("第1次订阅：", code)
            dismiss()
            let type : Int = code as! Int
            switch type {
            case 1:
                self.tableView .reloadData()
            default:
                print(type)
            }
        }).disposed(by: self.viewModel.disposeBag)
        
        //请求数据
        showLoading()
        self.viewModel.getUserData(isFirst: true)
        
        
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.dataArray.count;
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let userCell = tableView.dequeueReusableCell(withIdentifier: "GitUserCell") as! GitUserCell
        userCell.modelObject = nil
        userCell.backgroundColor = UIColorRandom();
        return userCell
    }
    
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

    //MARK: 懒加载
    lazy var tableView : LZBaseTableView = {
        let tableView = LZBaseTableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(GitUserCell.self, forCellReuseIdentifier: "GitUserCell")
        return tableView
    }()
    
}

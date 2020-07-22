//
//  GitUserView.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit
import XREasyRefresh
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
        headView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.5)
        self.tableView.tableHeaderView = headView
    
        self.tableView.reloadData()
        
        
        //MARK: 请求回调
        self.viewModel.publishSubject.subscribe(onNext: { [weak self] code in
            dismiss()
            if let weakSelf = self  {
                weakSelf.tableView.xr.endHeaderRefreshing()
                weakSelf.tableView.xr.endFooterRefreshing()

                weakSelf.tableView.reloadData()
                let type : Int = code as! Int
                    switch type {
                        case 0:
                            weakSelf.tableView.xr.endFooterRefreshingWithNoMoreData()
                        default:
                            print(type)
                }
                
                if(weakSelf.viewModel.dataArray.count == 0){
                    weakSelf.tableView.xr.endFooterRefreshingWithNoMoreData()
                }
            }
            
            
        }).disposed(by: self.viewModel.disposeBag)
        
        //请求数据
        showLoading()
        
        
        // 添加下拉刷新
        self.tableView.xr.addPullToRefreshHeader(refreshHeader: XRActivityRefreshHeader(), heightForHeader: 65, ignoreTopHeight: XRRefreshMarcos.xr_StatusBarHeight) { [weak self] in
            // do request...
            
            if let weakSelf = self {
               weakSelf.viewModel.getUserData(isFirst: true)
            }
        }
        
        // 添加上拉加载更多
        self.tableView.xr.addPullToRefreshFooter(refreshFooter: XRActivityRefreshFooter(), heightForFooter: 60, refreshingClosure: {  [weak self] in
            if let weakSelf = self {
                weakSelf.viewModel.getUserData(isFirst: false)
            }
        })
        
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let userCell = tableView.dequeueReusableCell(withIdentifier: "GitUserCell") as! GitUserCell
        if self.viewModel.dataArray.count > indexPath.row{
            userCell.modelObject = self.viewModel.dataArray[indexPath.row] as AnyObject
        }
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

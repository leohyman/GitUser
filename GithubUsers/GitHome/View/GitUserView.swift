//
//  GitUserView.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

class GitUserView: LZBaseView ,UITableViewDelegate,UITableViewDataSource{
    private var viewModel = GitUserViewModel()
    
    let isHeaderLoading = BehaviorRelay(value: false)
    let isFooterLoading = BehaviorRelay(value: false)
    
    override init(viewModel: LZBaseViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel as! GitUserViewModel
        setupUI()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bindViewModel() {
        let searchAction = searchBar.rx.text.orEmpty.asObservable()
        
        isHeaderLoading.bind(to: tableView.mj_header!.rx.loading).disposed(by: self.viewModel.disposeBag)
        
        isFooterLoading.bind(to: tableView.mj_footer!.rx.loading).disposed(by: self.viewModel.disposeBag)
        
    
        
        
        
    }
    
    //MARK: setupUI
    func setupUI()  {
        
        addSubview(searchBar)
        addSubview(tableView)
        
        searchBar.snp.makeConstraints { (make) in
            make.top.left.equalTo(0)
            make.height.equalTo(44)
            make.width.equalTo(kScreenWidth)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp_bottomMargin)
            make.left.right.equalTo(self)
            make.bottom.equalTo(0)
        }
        
    
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshBackNormalFooter()
        
        tableView.rx.willEndDragging.subscribe{[weak self] _ in

            guard let self = self else {return}
            self.searchBar.resignFirstResponder()
        }.disposed(by: self.viewModel.disposeBag)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //创建搜索框
        let userheadView = GitUserHeadView.init(viewModel: self.viewModel)
        addSubview(userheadView)
        userheadView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(40)
            make.top.equalTo(0)
        }
        
        
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(kScreenWidth)
            make.bottom.equalTo(0)
            make.top.equalTo(userheadView.snp.bottom)
        }
    
        self.tableView.reloadData()
        
        
        //MARK: 请求回调
        self.viewModel.publishSubject.subscribe(onNext: { [weak self] code in
//            dismiss()
//            if let weakSelf = self  {
//                weakSelf.tableView.es.stopPullToRefresh()
//                weakSelf.tableView.es.stopLoadingMore()
//
//                weakSelf.tableView.reloadData()
//                let type : Int = code as! Int
//                    switch type {
//                        case 0:
//                        weakSelf.tableView.es.noticeNoMoreData()
//
//                    default:break
//                }
//
//                if(weakSelf.viewModel.dataArray.count == 0){
//                    weakSelf.tableView.es.noticeNoMoreData()
//                }
//            }
            
            
        }).disposed(by: self.viewModel.disposeBag)
        
        //请求数据
//        showLoading()
//        self.viewModel.searchUser(search: self.viewModel.searchName , isFirst: true)
        
//        // 添加下拉刷新
//        self.tableView.es.addPullToRefresh {
//            [weak self] in
//            /// Do anything you want...
//            if let waekSelf = self {
//                waekSelf.viewModel.searchUser(search: waekSelf.viewModel.searchName, isFirst: true)
//            }
//        }
//
//        // 添加上拉加载更多
//        self.tableView.es.addInfiniteScrolling {
//            [weak self] in
//            /// Do anything you want...
//             if let waekSelf = self {
//
//                waekSelf.viewModel.searchUser(search: waekSelf.viewModel.searchName , isFirst: false)
//
//            }
//        }
        
      
        
//        self.tableView.expiredTimeInterval = 20.0
        
        
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.viewModel.dataArray.count > indexPath.row{
//            let userModel = self.viewModel.dataArray[indexPath.row] as! GitUserModel
//            let webVC = LZWebViewController()
//            webVC.webUrl = userModel.html_url
//            currentVC()?.navigationController?.pushViewController(webVC, animated: true)
        }
        
    }
    

    //MARK: 懒加载
    lazy var tableView : LZBaseTableView = {
        let tableView = LZBaseTableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.register(GitUserCell.self, forCellReuseIdentifier: "GitUserCell")
        return tableView
    }()
    
    
    
    lazy var searchBar : UISearchBar =  {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
}

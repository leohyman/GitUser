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

class GitUserView: LZBaseView {
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
        
        viewModel.bindAction(input: (searchAction: searchAction,
                                     headerRefresh: self.tableView.mj_header!.rx.refreshing.asObservable(),
                                     footerRefresh: self.tableView.mj_footer!.rx.refreshing.asObservable()))
        
        
        viewModel.headerLoading.asObservable().bind(to: isHeaderLoading).disposed(by: self.viewModel.disposeBag)
        viewModel.footerLoading.asObservable().bind(to: isFooterLoading).disposed(by: self.viewModel.disposeBag)
        
        
        // bind tableData to tableView
        viewModel.tableData.asDriver()
        .drive(tableView.rx.items) { (tableView, row, element) in
            let userCell = tableView.dequeueReusableCell(withIdentifier: "GitUserCell") as! GitUserCell
            userCell.modelObject = element as AnyObject
            return userCell
        }
        .disposed(by: self.viewModel.disposeBag)
//
//
//        viewModel.tableData
//            .bind(to: tableView.rx.items(cellIdentifier: "GitUserCell")){_,model,cell in
//
//                let userCell = cell as! GitUserCell
//                userCell.modelObject = model
//
//        }.disposed(by: self.viewModel.disposeBag)
//   
                
                
    
        
        // bind tableView select event

        tableView.rx.modelSelected(GitHubUser.self)
            .subscribe(onNext: {value in
                
                let webVC = LZWebViewController()
                webVC.webUrl = value.htmlUrl
                currentVC()?.navigationController?.pushViewController(webVC, animated: true)
                
            }).disposed(by: self.viewModel.disposeBag)
                
        
    }
    
    //MARK: setupUI
    func setupUI()  {
        
        addSubview(searchBar)
        addSubview(tableView)
        
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.right.equalTo(self)
            make.height.equalTo(60)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp_bottomMargin)
            make.left.equalTo(self)
            make.bottom.equalToSuperview().offset(0)
            make.width.equalTo(kScreenWidth)
        }

    
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshBackNormalFooter()
        
        tableView.rx.willEndDragging.subscribe{[weak self] _ in

            guard let self = self else {return}
            self.searchBar.resignFirstResponder()
        }.disposed(by: self.viewModel.disposeBag)
    
        self.tableView.reloadData()
    }
    
    

    //MARK: 懒加载
    lazy var tableView : LZBaseTableView = {
        let tableView = LZBaseTableView(frame: CGRect.zero, style: .plain)
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

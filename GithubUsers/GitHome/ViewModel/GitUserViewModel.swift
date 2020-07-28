//
//  GitUserViewModel.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya

class GitUserViewModel: LZBaseViewModel {

    var page = 1
    
    let tableData = BehaviorRelay<[GitHubUser]>(value: [])
    
    let keyword = BehaviorRelay(value:"swift")
    
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()
    

    deinit {
        print("\(self)释放了");
    }

    
    
    override init() {
        super.init()
        
    }
    
      /// transform singnal
     /// - Parameter input: (searchAction, heaserRefresh, footerRefresh)
     func bindAction(input:(searchAction: Observable<String>,
                           headerRefresh: Observable<Void>,
                           footerRefresh: Observable<Void> )){

         // search result sequence
         input.searchAction
            .filter { !$0.isEmpty }
            .flatMapLatest({ [weak self] keyword -> Observable<GitHubUsers> in
                 guard let self = self else { return Observable.empty() }
                 self.page = 1
                 return self.request(login: keyword, page: self.page)
            }).subscribe(onNext: { [weak self] (gitHubUsers) in
                 guard let self = self else { return }
                 self.tableData.accept(gitHubUsers.items)
            }, onError: { (error) in
                print("error")
         }).disposed(by: disposeBag)

         // bind search content to keyword
         input.searchAction
             .filter { !$0.isEmpty }
             .distinctUntilChanged()
             .asObservable()
             .bind(to: keyword).disposed(by: disposeBag)

        // headerRefresh result sequence
        input.headerRefresh
         .startWith(()) // when app launched start once
            .flatMapLatest({ [weak self] _ -> Observable<GitHubUsers> in
                 guard let self = self else { return Observable.empty() }
                 self.page = 1
                 return self.request(login: self.keyword.value, page: self.page).trackActivity(self.headerLoading)

         }).subscribe(onNext: { [weak self] (gitHubUsers) in
                 guard let self = self else { return }
                 self.tableData.accept(gitHubUsers.items)
            }, onError: { (error) in

                 print("error")

         }).disposed(by: disposeBag)

        // footerRefresh result sequence
        input.footerRefresh
            .flatMapLatest({ [weak self] _ -> Observable<GitHubUsers> in
                 guard let self = self else { return Observable.empty() }
                 self.page += 1
                return self.request(login: self.keyword.value, page: self.page).trackActivity(self.footerLoading)
            }).subscribe(onNext: { [weak self] (gitHubUsers) in
                    guard let self = self else { return }
                    self.tableData.accept(self.tableData.value + gitHubUsers.items )
               }, onError: { (error) in
                    print("error")

            }).disposed(by: disposeBag)

     }

     func request(login: String, page: Int) -> Observable<GitHubUsers> {
        return gitHubProvider.rx.request(.gitHubUsers(login, page))
            .filterSuccessfulStatusCodes()
            .mapObject(GitHubUsers.self)
            .asObservable()
     }
}




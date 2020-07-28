//
//  MJRefresh+Rx.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/28.
//  Copyright © 2020 吕VV. All rights reserved.
//

import Foundation
import MJRefresh
import RxSwift
import RxCocoa


extension Reactive where Base: MJRefreshComponent{
    
    //开始刷新
    var refreshing : ControlEvent<Void>{
        let source: Observable<Void> = Observable.create {
            [weak control = self.base] observer in
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    
    
    //刷线
    var loading: Binder<Bool>{
        return Binder(base) { refresh, isEnd in
            if !isEnd {
                refresh.endRefreshing()
            }
                
        }
    }
    
  

    
    
}

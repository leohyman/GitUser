//
//  LZNetAPIManager.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/6/30.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import Foundation
import Moya


//初始化请求 provider

let gitHubProvider = MoyaProvider<GitHubAPI>()


/**
 定义请求的endpodints (供provider使用)
 */
//请求分类
public enum GitHubAPI{
    
    case gitHubUsers(String,Int)                //搜索

 
    
}

//请求配置
extension GitHubAPI : TargetType{
 
    
 
    
    //服务地址
    public var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .gitHubUsers(_, _):
            return "search/users"
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        switch self {
        case .gitHubUsers(_,_):
            return .get
        }
        
    }
    
    //请求任事件, 带上参数
    public var task: Task {
        
        var params: [String : Any] = [:]

        switch self{
        case .gitHubUsers(let search, let page):
            params["q"] = search
            params["page"] = page
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)

        
    }
    
    //是否执行Alamofire 验证
    public var validate: Bool
    {
        return false
    }
    
    
    ///请求头
    public var headers: [String : String]? {
        return nil
    }
    
    public var sampleData: Data {
         return "{}".data(using: String.Encoding.utf8)!
     }

}





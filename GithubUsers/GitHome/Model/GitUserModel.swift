//
//  GitUserModel.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit
import ObjectMapper




struct GitHubUsers: Mappable{

    var totalCount:Int!
    var incompleteResults: Bool!
    var items :[GitHubUser]!
    
    init() {}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        totalCount        <- map["total_count"]
        incompleteResults <- map["incomplete_results"]
        items <- map["items"]
    }
}

struct GitHubUser: Mappable{
    var login: String?
    var htmlUrl: String?
    var avatarUrl: String?
    var score: Float!

    
    
    init() {}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        avatarUrl <- map["avatar_url"]
        login     <- map["login"]
        score     <- map["score"]
        htmlUrl   <- map["html_url"]
    }

}

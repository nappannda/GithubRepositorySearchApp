//
//  GithubRepository.swift
//  GithubRepositorySearchApp
//
//  Created by 上原和輝 on 2017/06/04.
//  Copyright © 2017年 nappannda. All rights reserved.
//
import ObjectMapper

class GithubRepositories: Mappable {
    var repositories: [GithubRepository]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        repositories <- map["items"]
    }
}

class GithubRepository: Mappable {
    var name: String?
    var user: GithubUser?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["full_name"]
        user <- map["owner"]
    }
}

class GithubUser: Mappable {
    var name: String?
    var avatarUrl: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["login"]
        avatarUrl <- map["avatar_url"]
    }
}

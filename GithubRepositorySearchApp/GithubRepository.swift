//
//  GithubRepository.swift
//  GithubRepositorySearchApp
//
//  Created by 上原和輝 on 2017/06/04.
//  Copyright © 2017年 nappannda. All rights reserved.
//

class GithubRepositories: Codable {
    var repositories = [GithubRepository]()
    
    enum CodingKeys: String, CodingKey {
        case repositories = "items"
    }
}

class GithubRepository: Codable {
    var name: String?
    var starNumber: Int?
    var language: String?
    var user: GithubUser?
    
    enum CodingKeys: String, CodingKey {
        case name = "full_name"
        case starNumber = "stargazers_count"
        case language = "language"
        case user = "owner"
    }
}

class GithubUser: Codable {
    var name: String?
    var avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarUrl = "avatar_url"
    }
}

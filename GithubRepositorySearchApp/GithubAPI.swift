//
//  GithubAPI.swift
//  GithubRepositorySearchApp
//
//  Created by 上原和輝 on 2017/06/05.
//  Copyright © 2017年 nappannda. All rights reserved.
//
import APIKit
import ObjectMapper

protocol GitHubRequest: Request {
    
}

extension GitHubRequest {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}

struct FetchRepositoriesRequest: GitHubRequest {
    
    var query: String?
    var sort: String?
    var order: String?
    
    typealias Response = GithubRepositories
    
    var path: String {
        return "/search/repositories"
    }
    var method: HTTPMethod {
        return .get
    }
    
    init(query: String, sort: String, order: String) {
        self.query = query
        self.sort = sort
        self.order = order
    }
    
    var parameters: Any? {
        return [
            "q" : query,
            "sort" : sort,
            "order" : order
        ]
    }

    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> FetchRepositoriesRequest.Response {
        return Mapper<GithubRepositories>().map(JSONObject: object)!
    }
}

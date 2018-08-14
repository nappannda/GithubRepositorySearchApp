//
//  DecodableDataParser.swift
//  GithubRepositorySearchApp
//
//  Created by 上原和輝 on 2018/08/14.
//  Copyright © 2018年 nappannda. All rights reserved.
//

import Foundation
import APIKit

final class DecodableDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        return data
    }
}

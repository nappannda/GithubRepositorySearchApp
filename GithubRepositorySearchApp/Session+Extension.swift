//
//  Session+Extension.swift
//  GithubRepositorySearchApp
//
//  Created by 上原和輝 on 2017/06/04.
//  Copyright © 2017年 nappannda. All rights reserved.
//

import APIKit
import RxSwift

extension Session {
    public static func rx_response<T: Request>(request: T) -> Observable<T.Response> {
        return Observable.create { observer in
            let task = send(request) { result in
                switch result {
                case .success(let response):
                    observer.onNext(response)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}

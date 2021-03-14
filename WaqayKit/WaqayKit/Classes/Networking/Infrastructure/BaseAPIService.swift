//
//  BaseAPIService.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation

public class BaseAPIService {
    let baseURLProvider: BaseURLProvider
    let serviceExecutor: URLServiceExecutor
    let jsonEncoder: JSONEncoder
    
    init(
        baseURLProvider: BaseURLProvider,
        serviceExecutor: URLServiceExecutor,
        jsonEncoder: JSONEncoder = .with(
            keyEncodingStrategy: .convertToSnakeCase
        )
    ) {
        self.baseURLProvider = baseURLProvider
        self.serviceExecutor = serviceExecutor
        self.jsonEncoder = jsonEncoder
    }
}

fileprivate extension JSONEncoder {
    static func with(
        keyEncodingStrategy: KeyEncodingStrategy
    ) -> JSONEncoder {
        let enconder = JSONEncoder()
        enconder.keyEncodingStrategy = keyEncodingStrategy
        return enconder
    }
}

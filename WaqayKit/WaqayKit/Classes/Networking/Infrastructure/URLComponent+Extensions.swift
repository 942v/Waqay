//
//  URLComponent+Extensions.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation

extension URLComponents {
    func request(_ method: URLRequest.Method) -> URLRequest {
        var request = self.request
        request.httpMethod = method.description
        request.httpBody = method.body
        return request
    }
    
    /// GET request
    var request: URLRequest {
        URLRequest(url: url!)
    }
}

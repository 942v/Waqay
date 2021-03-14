//
//  ApiaryURLProvider.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation

public class ApiaryURLProvider: BaseURLProvider {
    
    public init() {}
    
    public func baseURLComponent(
        appendingPath path: String?
    ) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "private-e1862-waqay.apiary-mock.com/api/v1"
        if let path = path {
            urlComponents.path = path
        }
        return urlComponents
    }
}

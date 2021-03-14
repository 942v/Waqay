//
//  URLServiceExecutor.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation
import PromiseKit

public protocol URLServiceExecutor {
    
    func requestPromise<T: Decodable>(
        _ request: URLRequest,
        type: T.Type
    ) -> Promise<T>
}

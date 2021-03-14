//
//  URLRequest+Extensions.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation

extension URLRequest {
    enum Method: CustomStringConvertible {
        case get
        case post(Data?)
        case put(Data)
        case delete
        
        var body: Data? {
            switch self {
                case .get: return nil
                case let .post(data): return data
                case let .put(data): return data
                case .delete: return nil
            }
        }
        
        var description: String {
            switch self {
                case .get: return "get"
                case .post: return "post"
                case .put: return "put"
                case .delete: return "delete"
            }
        }
    }
}

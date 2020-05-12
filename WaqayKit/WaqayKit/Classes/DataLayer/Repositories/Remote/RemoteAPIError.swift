//
//  RemoteAPIError.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/10/20.
//

import Foundation

public enum RemoteAPIError: Error {
    case unknown
    case createURL
    case httpError
}

extension RemoteAPIError: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .createURL:
            return "There was an error creating the URL"
        case .httpError:
            return "There was an error loading some data"
        case .unknown:
            return "An unknown error happen, try again"
        }
    }
}

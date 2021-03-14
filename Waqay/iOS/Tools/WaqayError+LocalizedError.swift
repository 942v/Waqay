//
//  WaqayError+LocalizedError.swift
//  Waqay
//
//  Created by Guillermo Sáenz on 3/13/21.
//  Copyright © 2021 Property Atomic Strong SAC. All rights reserved.
//

import Foundation
import WaqayKit

extension WaqayError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cache:
            return "This error should be handled by the app and not shown to the user"
        case let .networking(error):
            return error.errorDescription
        default:
            return "Something went wrong, try again"
        }
    }
    
    public var failureReason: String? {
        switch self {
        case let .networking(error):
            return error.failureReason
        default:
            return "Unknown reason"
        }
    }
}

extension WaqayError.Networking: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .client(error):
            return error.errorDescription
        case let .server(error):
            return error.errorDescription
        default:
            return "Try again later"
        }
    }
    
    public var failureReason: String? {
        switch self {
        case let .client(client):
            return client.failureReason
        default:
            return "Unknown reason"
        }
    }
}

extension WaqayError.Networking.Client: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .forbidden:
            return "403: You dont have access to this resource"
        case .badRequest:
            return "400: Something went wrong."
        case .unauthorized:
            return "401: You are not logged in."
        case let .decoding(error):
            return error.localizedDescription
        case .notFound:
            return "404: Not found"
        }
    }
    
    public var failureReason: String? {
        switch self {
        case let .decoding(error):
            return "\(error)"
        default:
            return "Unknown reason"
        }
    }
}

extension WaqayError.Networking.Server: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .internalError(error):
            guard let error = error else {
                return "500 Internal Server Error"
            }
            return "500: \(error)"
        case .timeout:
            return "Timeout"
        }
    }
    
    public var failureReason: String? {
        switch self {
        case let .internalError(error):
            guard let error = error else { return "Unknown" }
            return "\(error)"
        case .timeout:
            return "Timeout"
        }
    }
}

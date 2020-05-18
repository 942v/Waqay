//
//  Configuration.swift
//  Waqay
//
//  Created by Guillermo Sáenz on 5/17/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum APIKeys {
    static var osApiKey: String {
        return try! Configuration.value(for: "OS_API_KEY")
    }
}

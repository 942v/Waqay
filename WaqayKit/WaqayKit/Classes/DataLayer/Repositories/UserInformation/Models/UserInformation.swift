//
//  UserInformation.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation

public struct UserInformation {
    public let identifier: String
    public let selectedRadios: [RadioStation]
}

extension UserInformation: Codable {
    enum CodingKeys: String, CodingKey {
        case identifier
        case selectedRadios
    }
}

extension UserInformation: Equatable {}

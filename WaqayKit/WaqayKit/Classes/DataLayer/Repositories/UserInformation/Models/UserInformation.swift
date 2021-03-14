//
//  UserInformation.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation

public struct UserInformation {
    public let identifier: String
    public let selectedRadioStations: [RadioStation]
}

extension UserInformation: Codable {
    enum CodingKeys: String, CodingKey {
        case identifier
        case selectedRadioStations
    }
}

extension UserInformation: Equatable {}

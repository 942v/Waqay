//
//  RadioStationSocialNetworks.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation

public struct RadioStationSocialNetworks {
    public let instagram: String?
    public let facebook: String?
    public let youtube: String?
    public let twitter: String?
    public let whatsapp: String?
    public let telephoneNumber: String?
}

extension RadioStationSocialNetworks: Codable {
    enum CodingKeys: String, CodingKey {
        case instagram
        case facebook
        case youtube
        case twitter
        case whatsapp
        case telephoneNumber
    }
}

extension RadioStationSocialNetworks: Equatable {}

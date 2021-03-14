//
//  RadioStation.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation

public struct RadioStation {
    public let identifier: String
    public let name: String
    public let streams: [RadioStationStream]
    public let website: String?
    public let socialNetworks: RadioStationSocialNetworks?
    public let frequencies: [RadioStationFrequency]?
}

extension RadioStation: Codable {
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case streams
        case website = "webUrl"
        case socialNetworks
        case frequencies
    }
}

extension RadioStation: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

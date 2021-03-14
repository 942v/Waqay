//
//  RadioStationStream.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation

public struct RadioStationStream {
    public let subname: String?
    public let description: String?
    public let stream: String?
    public let renewStream: String?
    public let logo: String?
}

extension RadioStationStream: Codable {
    enum CodingKeys: String, CodingKey {
        case subname
        case description
        case stream = "streamUrl"
        case renewStream = "renewStreamUrl"
        case logo = "logoUrl"
    }
}

extension RadioStationStream: Equatable {}

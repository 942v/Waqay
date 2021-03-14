//
//  RadioStationFrequency.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation

public struct RadioStationFrequency {
    public let city: String?
    public let frecuency: String
    public let band: String
    
    public lazy var modulation: String = {
        "\(frecuency) \(band)"
    }()
}

extension RadioStationFrequency: Codable {
    enum CodingKeys: String, CodingKey {
        case city
        case frecuency
        case band
    }
}

extension RadioStationFrequency: Equatable {}

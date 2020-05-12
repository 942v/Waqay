//
//  RadioFrecuencyData.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/9/20.
//

import Foundation

public struct RadioFrequencyData {
    
    let city: String?
    let modulation: String
    
    enum CodingKeys: String, CodingKey {
        case city
        case frecuency
        case band
    }
}

extension RadioFrequencyData: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        let frecuency = try values.decode(String.self, forKey: .frecuency)
        let band = try values.decode(String.self, forKey: .band)
        modulation = "\(frecuency) \(band)"
    }
}

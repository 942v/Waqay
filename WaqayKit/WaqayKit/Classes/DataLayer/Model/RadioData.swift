//
//  RadioData.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/9/20.
//

import Foundation

public struct RadioResponseData {
    let data: [RadioData]
}

extension RadioResponseData: Decodable { }

public struct RadioData {
    
    let id: Int
    let name: String
    let streams: [RadioStreamData]
    let website: URL?
    let socialNetworks: RadioSocialNetworksData?
    let frequencies: [RadioFrequencyData]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case streams
        case frequencies
        case website = "web_url"
        case socialNetworks = "social_networks"
    }
}

extension RadioData: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        streams = try values.decode([RadioStreamData].self, forKey: .streams)
        frequencies = try values.decodeIfPresent([RadioFrequencyData].self, forKey: .frequencies)
        website = try RadioData.decodeURL(from: values, forKey: .website)
        socialNetworks = try values.decodeIfPresent(RadioSocialNetworksData.self, forKey: .socialNetworks)
    }
    
    private static func decodeURL(from values: KeyedDecodingContainer<CodingKeys>,
                                  forKey: CodingKeys) throws -> URL? {
        if let urlString = try values.decodeIfPresent(String.self, forKey: forKey) {
            return URL(string: urlString)
        }
        
        return nil
    }
}

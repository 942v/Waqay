//
//  RadioStreamData.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/10/20.
//

import Foundation

public struct RadioStreamData {
    
    let subname: String?
    let description: String?
    let stream: URL?
    let renewStream: URL?
    let logo: URL?
    
    enum CodingKeys: String, CodingKey {
        case subname
        case description
        case stream = "stream_url"
        case renewStream = "renew_stream_url"
        case logo = "logo_url"
    }
}

extension RadioStreamData: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        subname = try values.decodeIfPresent(String.self, forKey: .subname)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        stream = try RadioStreamData.decodeURL(from: values, forKey: .stream)
        renewStream = try RadioStreamData.decodeURL(from: values, forKey: .renewStream)
        logo = try RadioStreamData.decodeURL(from: values, forKey: .logo)
    }
    
    private static func decodeURL(from values: KeyedDecodingContainer<CodingKeys>,
                                  forKey: CodingKeys) throws -> URL? {
        if let urlString = try values.decodeIfPresent(String.self, forKey: forKey) {
            return URL(string: urlString)
        }
        
        return nil
    }
}

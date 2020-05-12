//
//  RadioNetworksData.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/9/20.
//

import Foundation

public struct RadioSocialNetworksData {
    let instagram: String?
    let facebook: String?
    let youtube: URL?
    let twitter: String?
    let whatsapp: String?
    let telephoneNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case instagram
        case facebook
        case youtube
        case twitter
        case whatsapp
        case telephoneNumber = "telephone_number"
    }
}

extension RadioSocialNetworksData: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        instagram = try values.decodeIfPresent(String.self, forKey: .instagram)
        facebook = try values.decodeIfPresent(String.self, forKey: .facebook)
        youtube = try RadioSocialNetworksData.decodeURL(from: values, forKey: .youtube)
        twitter = try values.decodeIfPresent(String.self, forKey: .twitter)
        whatsapp = try values.decodeIfPresent(String.self, forKey: .whatsapp)
        telephoneNumber = try values.decodeIfPresent(String.self, forKey: .telephoneNumber)
    }
    
    private static func decodeURL(from values: KeyedDecodingContainer<CodingKeys>,
                                  forKey: CodingKeys) throws -> URL? {
        if let urlString = try values.decodeIfPresent(String.self, forKey: forKey) {
            return URL(string: urlString)
        }
        
        return nil
    }
}

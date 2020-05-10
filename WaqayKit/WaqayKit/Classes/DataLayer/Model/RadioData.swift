//
//  RadioData.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/9/20.
//

import Foundation

public protocol RadioDataType {
    
    var logo: URL { get }
    var name: String { get }
    var frequencies: [RadioFrequencyData] { get }
    var knownStreamURL: URL { get }
    var renewStreamURL: URL? { get }
    var website: URL? { get }
    var networks: [RadioNetworkData] { get }
}

public struct RadioData: RadioDataType {
    
    public let logo: URL
    
    public let name: String
    
    public let frequencies: [RadioFrequencyData]
    
    public let knownStreamURL: URL
    
    public let renewStreamURL: URL?
    
    public let website: URL?
    
    public let networks: [RadioNetworkData]
    
}

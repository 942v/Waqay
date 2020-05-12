//
//  WaqayFakeRadiosRemoteDataAPI.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/9/20.
//

import Foundation
import PromiseKit

public class WaqayFakeRadiosRemoteDataAPI: RadiosDataRemoteAPI {
    
    public init() {}
    
    public func getRadiosData() -> Promise<[RadioData]> {
        return Promise<[RadioData]> { seal in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                let radioData = WaqayFakeRadiosRemoteDataAPI.makeRPPRadioData()
                
                seal.fulfill(radioData)
            }
        }
    }
}

private extension WaqayFakeRadiosRemoteDataAPI {
    class func makeRPPRadioData() -> [RadioData] {
        func makeFakeFrequencies() -> [RadioFrequencyData] {
            let fm = RadioFrequencyData(city: "Lima",
                                        modulation: "89.7 FM")
            return [fm]
        }
        
        func makeFakeNetworks() -> RadioSocialNetworksData {
            return RadioSocialNetworksData(instagram: nil,
                                           facebook: "rppnoticias",
                                           youtube: nil,
                                           twitter: nil,
                                           whatsapp: nil,
                                           telephoneNumber: nil)
        }
        
        func makeFakeStreams() -> [RadioStreamData] {
            let logoURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/04/RPP_TV_-_2017_logo.png")!
            let stream = URL(string: "https://google.com")!
            
            return [RadioStreamData(subname: nil,
                                   description: nil,
                                   stream: stream,
                                   renewStream: nil,
                                   logo: logoURL)]
        }
        let name = "RPP Noticias"
        let streams = makeFakeStreams()
        let website = URL(string: "https://rpp.pe")!
        let networks = makeFakeNetworks()
        let frequencies = makeFakeFrequencies()
        
        let radio = RadioData(id: 0,
                              name: name,
                              streams: streams,
                              website: website,
                              socialNetworks: networks,
                              frequencies: frequencies)
        
        return [radio]
    }
}

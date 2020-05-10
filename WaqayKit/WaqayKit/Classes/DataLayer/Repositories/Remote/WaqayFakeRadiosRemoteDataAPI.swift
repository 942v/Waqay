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
            let fm = RadioFrequencyData(modulation: "89.7")
            return [fm]
        }
        func makeFakeNetworks() -> [RadioNetworkData] {
            let facebookLogo = URL(string: "https://icons.iconarchive.com/icons/danleech/simple/256/facebook-icon.png")!
            let facebookName = "facebook"
            let facebookWebsite = URL(string: "https://www.facebook.com/rppnoticias/")!
            let facebook = RadioNetworkData(logo: facebookLogo,
                                            name: facebookName,
                                            website: facebookWebsite)
            
            return [facebook]
        }
        
        let logoURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/04/RPP_TV_-_2017_logo.png")!
        let name = "RPP Noticias"
        
        let frequencies = makeFakeFrequencies()
        let knownStreamURL = URL(string: "")!
        let website = URL(string: "https://rpp.pe")!
        
        let networks = makeFakeNetworks()
        
        return [RadioData(logo: logoURL,
                         name: name,
                         frequencies: frequencies,
                         knownStreamURL: knownStreamURL,
                         renewStreamURL: nil,
                         website: website,
                         networks: networks)]
    }
}

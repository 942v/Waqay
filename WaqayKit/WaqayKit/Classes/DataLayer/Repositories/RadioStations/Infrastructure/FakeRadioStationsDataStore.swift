//
//  FakeRadioStationsDataStore.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit
import RxSwift
import CocoaLumberjack

class FakeRadioStationsDataStore: RadioStationsDataStore {
    
    // MARK: - Properties
    
    // MARK: Rx
    public let radioStations: BehaviorSubject<[RadioStation]>
    
    // MARK: - Methods
    init(
        hasRadioStations: Bool
    ) {
        var value: [RadioStation]
        switch hasRadioStations {
        case true:
            value = Self.runHasRadioStations()
        case false:
            value = Self.runDoesNotHaveRadioStations()
        }
        
        self.radioStations = BehaviorSubject<[RadioStation]>(value: value)
    }
}

extension FakeRadioStationsDataStore {
    
    func save(
        _ radioStations: [RadioStation]
    ) -> Promise<Void> {
        self.radioStations.onNext(radioStations)
        return .value
    }
}

fileprivate extension FakeRadioStationsDataStore {
    
    class func runHasRadioStations() -> [RadioStation] {
        DDLogInfo("Try to read radio stations from fake disk...")
        DDLogInfo("  simulating having 1 radio station with fake data...")
        DDLogInfo("  returning radio station with fake data...")
        
        func makeFakeFrequencies() -> [RadioStationFrequency] {
            let fm = RadioStationFrequency(
                city: "Lima",
                frecuency: "89.7",
                band: "FM"
            )
            return [fm]
        }
        
        func makeFakeNetworks() -> RadioStationSocialNetworks {
            return RadioStationSocialNetworks(
                instagram: nil,
                facebook: "rppnoticias",
                youtube: nil,
                twitter: nil,
                whatsapp: nil,
                telephoneNumber: nil
            )
        }
        
        func makeFakeStreams() -> [RadioStationStream] {
            let logoURL = "https://upload.wikimedia.org/wikipedia/commons/0/04/RPP_TV_-_2017_logo.png"
            let stream = "https://google.com"
            
            return [RadioStationStream(
                subname: nil,
                description: nil,
                stream: stream,
                renewStream: nil,
                logo: logoURL
            )]
        }
        let name = "RPP Noticias"
        let streams = makeFakeStreams()
        let website = "https://rpp.pe"
        let networks = makeFakeNetworks()
        let frequencies = makeFakeFrequencies()
        
        let radio = RadioStation(
            identifier: "0",
            name: name,
            streams: streams,
            website: website,
            socialNetworks: networks,
            frequencies: frequencies
        )
        
        return [radio]
    }
    
    class func runDoesNotHaveRadioStations() -> [RadioStation] {
        DDLogInfo("Try to read radio station from fake disk...")
        DDLogInfo("  simulating empty disk...")
        DDLogInfo("  returning empty...")
        return []
    }
}

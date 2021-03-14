//
//  RadioStationsRepositoryFactory.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation

public class RadioStationsRepositoryFactory {
    
    public class func radioStationsRepository(
        baseURLProvider : BaseURLProvider
    ) -> RadioStationsRepository {
        
        func makeRadioStationsDataStore() -> RadioStationsDataStore {
            FakeRadioStationsDataStore(
                hasRadioStations: true
            )
            // TODO: setup real data store
//            WaqayRadioStationsDataStore()
        }
        
        func makeServiceExecutor() -> URLServiceExecutor {
            let executor = URLSessionServiceExecutor(
                session: .shared
            )
            
            return executor
        }
        
        func makeRadioStationsProvider() -> RadioStationsProvider {
            let baseURLProvider = baseURLProvider
            let serviceExecutor = makeServiceExecutor()
            
            return RemoteRadioStationsProvider(
                baseURLProvider: baseURLProvider,
                serviceExecutor: serviceExecutor
            )
        }
        
        let dataStore = makeRadioStationsDataStore()
        let provider = makeRadioStationsProvider()
        
        return WaqayRadioStationsRepository(
            dataStore: dataStore,
            provider: provider
        )
    }
}


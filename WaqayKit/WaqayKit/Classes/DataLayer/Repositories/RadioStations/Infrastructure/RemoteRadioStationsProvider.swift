//
//  RemoteRadioStationsProvider.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit

class RemoteRadioStationsProvider: BaseAPIService, RadioStationsProvider {
}

extension RemoteRadioStationsProvider {
    func getRadioStations(
    ) -> Promise<[RadioStation]> {
        
        let baseURL = baseURLProvider
            .baseURLComponent(appendingPath: "/radio-stations")
        
        return serviceExecutor
            .requestPromise(
                baseURL.request,
                type: [RadioStation].self
            )
    }
}


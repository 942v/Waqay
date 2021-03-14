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
            .baseURLComponent(appendingPath: "/api/v1/radio-stations")
        
        return serviceExecutor
            .requestPromise(
                baseURL.request,
                type: [String:[RadioStation]].self
            )
            .map { $0["data"]! }
    }
}


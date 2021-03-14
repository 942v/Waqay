//
//  RadioStationsProvider.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit

protocol RadioStationsProvider: BaseAPIService {
    func getRadioStations() -> Promise<[RadioStation]>
}

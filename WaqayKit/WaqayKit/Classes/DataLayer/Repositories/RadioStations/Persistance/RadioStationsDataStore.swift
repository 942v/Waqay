//
//  RadioStationsDataStore.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit
import RxSwift

protocol RadioStationsDataStore {
    
    var radioStations: BehaviorSubject<[RadioStation]> { get }
    func save(
        _ radioStations: [RadioStation]
    ) -> Promise<Void>
}

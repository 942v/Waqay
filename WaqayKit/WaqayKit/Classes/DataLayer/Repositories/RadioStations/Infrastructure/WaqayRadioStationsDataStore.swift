//
//  WaqayRadioStationsDataStore.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit
import RxSwift

class WaqayRadioStationsDataStore: RadioStationsDataStore {
    
    // MARK: - Properties
    fileprivate let accessQueue = DispatchQueue(label: "com.proatomicdev.waqay.radiostationsdatastore.inmemorystore.access")
    
    // MARK: Rx
    public let radioStations = BehaviorSubject<[RadioStation]>(value: [])
    
    // MARK: - Methods
    init() { }
}

extension WaqayRadioStationsDataStore {
    
    func save(
        _ radioStations: [RadioStation]
    ) -> Promise<Void> {
        return Promise { seal in
            self.accessQueue.async {
                self.radioStations.onNext(radioStations)
                seal.fulfill_()
            }
        }
    }
}

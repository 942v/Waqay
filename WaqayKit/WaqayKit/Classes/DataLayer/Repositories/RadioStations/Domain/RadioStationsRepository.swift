//
//  RadioStationsRepository.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit
import RxSwift

public protocol RadioStationsRepository {
    
    var radioStations: BehaviorSubject<[RadioStation]> { get }
    
    func loadRadioStations(
    ) -> Promise<Void>
}

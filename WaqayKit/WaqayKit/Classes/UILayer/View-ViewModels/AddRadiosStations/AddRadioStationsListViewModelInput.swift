//
//  AddRadioStationsListViewModelInput.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation
import RxSwift

public protocol AddRadioStationsListViewModelInput {
    var view: Observable<AddRadioStationsView> { get }
    var errorMessages: Observable<WaqayError> { get }
    var radioStationsData: BehaviorSubject<[AddRadioStationsData]> { get }
    var doneButtonEnabled: BehaviorSubject<Bool> { get }
    
    func loadRadioStations()
    func didSelect(_ radioStationData: AddRadioStationsData)
    
    func didFinishAddingRadios()
}

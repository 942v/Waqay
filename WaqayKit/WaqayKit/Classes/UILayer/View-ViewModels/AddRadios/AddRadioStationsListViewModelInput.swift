//
//  AddRadioStationsListViewModelInput.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation
import RxSwift

public protocol AddRadioStationsListViewModelInput {
    var view: Observable<AddRadiosView> { get }
    var errorMessages: Observable<WaqayError> { get }
    var radioStations: BehaviorSubject<[RadioStation]> { get }
    var doneButtonEnabled: BehaviorSubject<Bool> { get }
    
    func loadRadioStations()
    func didSelect(_ radioStation: RadioStation)
    
    func didFinishAddingRadios()
}

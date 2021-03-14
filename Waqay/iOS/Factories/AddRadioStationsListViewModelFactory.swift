//
//  AddRadiosViewModelFactory.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/10/20.
//

import WaqayKit

public protocol AddRadioStationsListViewModelFactory {
    
    func makeAddRadioStationsListViewModel() -> AddRadioStationsListViewModelInput
}

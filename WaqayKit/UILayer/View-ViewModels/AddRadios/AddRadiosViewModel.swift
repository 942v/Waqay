//
//  AddRadiosViewModel.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import Foundation

public class AddRadiosViewModel {
    
    private unowned let radiosDataRepository: RadiosDataRepository
    private unowned let didFinishAddingRadiosNavigator: DidFinishAddingRadiosNavigator
    
    init(radiosDataRepository: RadiosDataRepository,
         didFinishAddingRadiosNavigator: DidFinishAddingRadiosNavigator) {
        self.radiosDataRepository = radiosDataRepository
        self.didFinishAddingRadiosNavigator = didFinishAddingRadiosNavigator
    }
}

// MARK: - Actions
extension AddRadiosViewModel {
    
    @objc public func didFinishAddingRadios() {
        
    }
}

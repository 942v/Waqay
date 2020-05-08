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
    private unowned let didFinishAddingRadiosResponder: DidFinishAddingRadiosResponder
    
    init(radiosDataRepository: RadiosDataRepository,
         didFinishAddingRadiosResponder: DidFinishAddingRadiosResponder) {
        self.radiosDataRepository = radiosDataRepository
        self.didFinishAddingRadiosResponder = didFinishAddingRadiosResponder
    }
}

// MARK: - Actions
extension AddRadiosViewModel {
    
    @objc public func didFinishAddingRadios() {
        
    }
}

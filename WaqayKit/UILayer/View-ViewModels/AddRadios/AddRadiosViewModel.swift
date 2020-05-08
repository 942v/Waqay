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
    private unowned let goToPlayerNavigator: GoToPlayerNavigator
    
    init(radiosDataRepository: RadiosDataRepository,
         goToPlayerNavigator: GoToPlayerNavigator) {
        self.radiosDataRepository = radiosDataRepository
        self.goToPlayerNavigator = goToPlayerNavigator
    }
}

// MARK: - Actions
extension AddRadiosViewModel {
    
    @objc public func didFinishAddingRadios() {
        goToPlayerNavigator.navigateToPlayer()
    }
}

//
//  WelcomeViewModel.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import Foundation

public class WelcomeViewModel {
    
    private unowned let addRadiosResponder: AddRadiosResponder
    
    init(addRadiosResponder: AddRadiosResponder) {
        self.addRadiosResponder = addRadiosResponder
    }
}

// MARK: - Actions
extension WelcomeViewModel {
    
    @objc public func showAddRadios() {
        
    }
}

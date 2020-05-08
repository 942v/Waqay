//
//  LaunchViewModel.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import Foundation

public class LaunchViewModel {
    
    private unowned let radiosDataRepository: RadiosDataRepository
    private unowned let noRadiosSelectedResponder: NoRadiosSelectedResponder
    private unowned let hasRadiosSelectedResponder: HasRadiosSelectedResponder
    
    init(radiosDataRepository: RadiosDataRepository,
         noRadiosSelectedResponder: NoRadiosSelectedResponder,
         hasRadiosSelectedResponder: HasRadiosSelectedResponder) {
        self.radiosDataRepository = radiosDataRepository
        self.noRadiosSelectedResponder = noRadiosSelectedResponder
        self.hasRadiosSelectedResponder = hasRadiosSelectedResponder
    }
}

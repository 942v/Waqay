//
//  LaunchViewModel.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import Foundation
import PromiseKit

public class LaunchViewModel {
    
    private unowned let radiosDataRepository: RadiosDataRepository
    private unowned let noRadiosSelectedResponder: NoRadiosSelectedResponder
    private unowned let hasRadiosSelectedResponder: HasRadiosSelectedResponder
    
    public init(radiosDataRepository: RadiosDataRepository,
         noRadiosSelectedResponder: NoRadiosSelectedResponder,
         hasRadiosSelectedResponder: HasRadiosSelectedResponder) {
        self.radiosDataRepository = radiosDataRepository
        self.noRadiosSelectedResponder = noRadiosSelectedResponder
        self.hasRadiosSelectedResponder = hasRadiosSelectedResponder
    }
}

extension LaunchViewModel {
    public func loadData() {
        radiosDataRepository.hasRadiosSelected().done(goToNextScreen(hasRadioSelected:)).catch { [weak self] error in
            guard let selfStrong = self else { return }
            print("Couldn't get data")
            selfStrong.goToNextScreen(hasRadioSelected: false)
        }
    }
    
    func goToNextScreen(hasRadioSelected: Bool) {
        switch hasRadioSelected {
        case true:
            hasRadiosSelectedResponder.hasRadiosSelected()
        case false:
            noRadiosSelectedResponder.noRadiosSelected()
        }
    }
}

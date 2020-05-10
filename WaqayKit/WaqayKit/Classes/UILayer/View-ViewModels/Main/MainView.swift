//
//  MainView.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import Foundation

public enum MainView {
    case launching
    case onboarding
    case player
}

extension MainView: Equatable {
    
    public static func ==(lhs: MainView, rhs: MainView) -> Bool {
        switch (lhs, rhs) {
        case (.launching, .launching):
            return true
        case (.onboarding, .onboarding):
            return true
        case (.player, .player):
            return true
        case (.launching, _),
             (.onboarding, _),
             (.player, _):
            return false
        }
    }
}

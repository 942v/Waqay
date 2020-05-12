//
//  OnboardingView.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import Foundation

public enum OnboardingView {
    case welcome
    case addRadios
    case pushPermission
    
    public func shouldHideNavigationBar() -> Bool {
        switch self {
        case .welcome:
            return true
        case .pushPermission:
            return true
        default:
            return false
        }
    }
}

//
//  UIViewController+Waqay_iOS.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//

import UIKit

public enum Storyboard: String {
    case launchStoryboard = "Launch"
    case welcomeStoryboard = "Welcome"
    case addRadioStationsStoryboard = "AddRadioStations"
    case pushPermissionStoryboard = "PushPermission"
}

public extension UIViewController {
    class func instantiate(from storyboard: Storyboard, framework: String? = nil) -> Self {
        return instantiate(from: storyboard.rawValue, framework: framework)
    }
}

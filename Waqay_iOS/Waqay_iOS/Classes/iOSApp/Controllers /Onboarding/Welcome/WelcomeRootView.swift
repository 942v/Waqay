//
//  WelcomeRootView.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import UIKit
import WaqayKit

class WelcomeRootView: UIView {
    
    private unowned var viewModel: WelcomeViewModel!
    
    public func inject(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Actions
extension WelcomeRootView {
    @IBAction func doStartAction(_ sender: Any) {
        viewModel.showAddRadios()
    }
}

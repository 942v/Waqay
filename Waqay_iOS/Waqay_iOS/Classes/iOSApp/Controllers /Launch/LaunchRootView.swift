//
//  LaunchRootView.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import UIKit
import WaqayKit

class LaunchRootView: UIView {
    
    private unowned var viewModel: LaunchViewModel!
    
    public func inject(viewModel: LaunchViewModel) {
        self.viewModel = viewModel
        
        loadData()
    }
    
    private func loadData() {
        viewModel.loadData()
    }
}

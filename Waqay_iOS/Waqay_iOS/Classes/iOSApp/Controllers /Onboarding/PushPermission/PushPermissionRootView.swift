//
//  PushPermissionRootView.swift
//  Pods
//
//  Created by Guillermo Sáenz on 5/17/20.
//

import UIKit
import WaqayKit

class PushPermissionRootView: UIView {
    
    private unowned var viewModel: PushPermissionViewModel!
    
    public func inject(viewModel: PushPermissionViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Actions
extension PushPermissionRootView {
    
    @IBAction func doAskForPermissionAction(_ sender: Any) {
        viewModel.showPlayer()
    }
    
    @IBAction func doDismissAction(_ sender: Any) {
        viewModel.showPlayer()
    }
}

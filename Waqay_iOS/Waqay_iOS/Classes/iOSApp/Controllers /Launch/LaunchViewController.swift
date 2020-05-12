//
//  LaunchViewController.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import UIKit
import WaqayKit

public class LaunchViewController: UIViewController {
    
    @IBOutlet var rootView: LaunchRootView!
    
    private var viewModel: LaunchViewModel!
    
    public func inject(launchViewModelFactory: LaunchViewModelFactory) {
        self.viewModel = launchViewModelFactory.makeLaunchViewModel()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView.inject(viewModel: viewModel)
    }
}

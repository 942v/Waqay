//
//  WelcomeViewController.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import UIKit
import WaqayKit

public class WelcomeViewController: UIViewController {
    
    @IBOutlet var rootView: WelcomeRootView!
    
    private var viewModel: WelcomeViewModel!
    
    public func inject(welcomeViewModelFactory: WelcomeViewModelFactory) {
        self.viewModel = welcomeViewModelFactory.makeWelcomeViewModel()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView.inject(viewModel: viewModel)
    }
}

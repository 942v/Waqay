//
//  PushPermissionViewController.swift
//  Waqay
//
//  Created by Guillermo Sáenz on 5/17/20.
//

import UIKit
import WaqayKit

public class PushPermissionViewController: UIViewController {
    
    @IBOutlet var rootView: PushPermissionRootView!
    
    private var viewModel: PushPermissionViewModel!
    
    public func inject(pushPermissionViewModelFactory: PushPermissionViewModelFactory) {
        self.viewModel = pushPermissionViewModelFactory.makePushPermissionViewModel()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView.inject(viewModel: viewModel)
    }
}

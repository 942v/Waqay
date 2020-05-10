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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

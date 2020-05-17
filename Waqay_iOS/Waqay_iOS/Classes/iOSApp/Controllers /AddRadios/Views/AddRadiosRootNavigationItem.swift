//
//  AddRadiosNavigationItem.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/10/20.
//

import UIKit
import WaqayKit

class AddRadiosRootNavigationItem: UINavigationItem {
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    private unowned var viewModel: AddRadiosViewModel!
    
    public func inject(viewModel: AddRadiosViewModel) {
        self.viewModel = viewModel
        
        setup()
    }

    private func setup() {
        title = viewModel.title()
    }
}

extension AddRadiosRootNavigationItem {
    @IBAction func doDoneAction(_ sender: Any) {
        viewModel.didFinishAddingRadios()
    }
}

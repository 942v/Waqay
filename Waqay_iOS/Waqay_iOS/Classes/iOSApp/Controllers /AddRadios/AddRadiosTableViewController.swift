//
//  AddRadiosTableViewController.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/10/20.
//

import UIKit
import WaqayKit

class AddRadiosTableViewController: UITableViewController {
    
    @IBOutlet weak var rootView: AddRadiosRootTableView!
    
    private var viewModel: AddRadiosViewModel!
    
    public func inject(viewModelFactory: AddRadiosViewModelFactory) {
        self.viewModel = viewModelFactory.makeAddRadiosViewModelFactory()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navigationItem = navigationItem as? AddRadiosRootNavigationItem else {
            return
        }
        navigationItem.inject(viewModel: viewModel)
        rootView.inject(viewModel: viewModel)
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

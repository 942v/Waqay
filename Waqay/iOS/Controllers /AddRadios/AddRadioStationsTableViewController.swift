//
//  AddRadiosTableViewController.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/10/20.
//

import UIKit
import RxSwift
import WaqayKit

class AddRadioStationsTableViewController: UITableViewController {
    
    // MARK: - Properties
    @IBOutlet weak var rootView: AddRadioStationsRootTableView!
    
    // MARK: ViewModel
    private var viewModel: AddRadioStationsListViewModelInput!
    
    // MARK: Rx
    private let disposeBag = DisposeBag()
    
    public func inject(
        viewModelFactory: AddRadioStationsListViewModelFactory
    ) {
        self.viewModel = viewModelFactory
            .makeAddRadioStationsListViewModel()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        observeViewModel()
        
        setupNavigationItem()
        rootView.inject(viewModel: viewModel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func observeViewModel() {
        let observable = viewModel
            .view
            .distinctUntilChanged()
        subscribe(to: observable)
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

// MARK: - Setup

private extension AddRadioStationsTableViewController {
    
    func setupNavigationItem() {
        
        title = R.string.addRadioStations.title()
        
        guard let navigationItem = navigationItem as? AddRadioStationsRootNavigationItem else {
            return
        }
        navigationItem.inject(viewModel: viewModel)
    }
    
    func setupTableView() {
        
        tableView.insetsContentViewsToSafeArea = true
        tableView.contentInsetAdjustmentBehavior = .automatic
    }
}

extension AddRadioStationsTableViewController {
    
    func subscribe(to observable: Observable<AddRadioStationsView>) {
        observable.subscribe(onNext: { [weak self] view in
            guard let strongSelf = self else { return }
            strongSelf.updateViewState(view)
        }).disposed(by: disposeBag)
    }
    
    func updateViewState(_ view: AddRadioStationsView) {
        switch view {
        case .loading:
            showLoadingView()
        case .failure(let error):
            showErrorView(for: error)
        case .showingData:
            clearBackgroundView()
        }
    }
    
    func showLoadingView() {
        tableView.backgroundView = AddRadioStationsRootLoadingView()
    }
    
    func showErrorView(for error: WaqayError) {
        tableView.backgroundView = AddRadioStationsRootErrorView(error: error)
    }
    
    func clearBackgroundView() {
        tableView.backgroundView = nil
    }
}

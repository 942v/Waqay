//
//  AddRadiosTableViewController.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/10/20.
//

import UIKit
import RxSwift
import WaqayKit

class AddRadiosTableViewController: UITableViewController {
    
    @IBOutlet weak var rootView: AddRadiosRootTableView!
    
    private var viewModel: AddRadioStationsListViewModelInput!
    
    private let disposeBag = DisposeBag()
    
    public func inject(
        viewModelFactory: AddRadioStationsListViewModelFactory
    ) {
        self.viewModel = viewModelFactory.makeAddRadioStationsListViewModel()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navigationItem = navigationItem as? AddRadiosRootNavigationItem else {
            return
        }
        observeViewModel()
        
        navigationItem.inject(viewModel: viewModel)
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

extension AddRadiosTableViewController {
    
    func subscribe(to observable: Observable<AddRadiosView>) {
        observable.subscribe(onNext: { [weak self] view in
            guard let strongSelf = self else { return }
            strongSelf.updateViewState(view)
        }).disposed(by: disposeBag)
    }
    
    func updateViewState(_ view: AddRadiosView) {
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
        tableView.backgroundView = AddRadiosRootLoadingView()
    }
    
    func showErrorView(for error: WaqayError) {
        tableView.backgroundView = AddRadiosRootErrorView(error: error)
    }
    
    func clearBackgroundView() {
        tableView.backgroundView = nil
    }
}

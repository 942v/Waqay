//
//  AddRadiosRootTableView.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/10/20.
//

import UIKit
import WaqayKit
import RxSwift
import PATools

fileprivate enum CellIdentifier: String {
    case cell = "RadioCell"
}

class AddRadiosRootTableView: UITableView {
    
    // MARK: - Properties
    
    // MARK: ViewModel
    private var viewModel: AddRadioStationsListViewModelInput!
    
    // MARK: Rx
    private var radioStations = BehaviorSubject<[RadioStation]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    public func inject(
        viewModel: AddRadioStationsListViewModelInput
    ) {
        self.viewModel = viewModel
        
        self.delegate = self
        self.dataSource = self
        
        observeViewModel()
        viewModel
            .loadRadioStations()
    }
}

// MARK: - Bindings

// MARK: Dynamic behavior
private extension AddRadiosRootTableView {
    
    func observeViewModel() {
        
        viewModel
            .radioStations
            .asDriver(onErrorRecover: { _ in fatalError("Encountered unexpected view model radio stations observable error.") })
            .drive(radioStations)
            .disposed(by: disposeBag)
        
        radioStations
            .asDriver(onErrorRecover: { _ in fatalError("Encountered unexpected radio stations observable error.") })
            .drive(onNext: { [weak self] _ in self?.reloadData() })
            .disposed(by: disposeBag)
    }
}

// MARK - UITableViewDataSource

extension AddRadiosRootTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try radioStations.value().count
        } catch {
            fatalError("Error reading value from list data subject.")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        do {
            let radioStation = try radioStations.value()[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CellIdentifier.cell.rawValue
            )!
            
            configure(
                cell: cell,
                with: radioStation
            )
            
            return cell
        } catch {
            fatalError("Error reading value from list data subject.")
        }
    }
}

// MARK - UITableViewDelegate

extension AddRadiosRootTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            let radioStation = try radioStations.value()[indexPath.row]
            viewModel
                .didSelect(radioStation)
        } catch {
            fatalError("Error reading value from list data subject.")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Helpers

private extension AddRadiosRootTableView {
    func configure(
        cell: UITableViewCell,
        with radioStation: RadioStation
    ) {
        
        guard let cell = cell as? AddRadiosRootTableViewCell else {
            return
        }
        
        cell.textLabel?.text = radioStation.name
    }
}

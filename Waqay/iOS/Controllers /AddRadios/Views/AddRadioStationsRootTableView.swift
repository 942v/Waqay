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

class AddRadioStationsRootTableView: UITableView {
    
    // MARK: - Properties
    
    // MARK: ViewModel
    private var viewModel: AddRadioStationsListViewModelInput!
    
    // MARK: Rx
    private var radioStationsData = BehaviorSubject<[AddRadioStationsData]>(value: [])
    
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
private extension AddRadioStationsRootTableView {
    
    func observeViewModel() {
        
        viewModel
            .radioStationsData
            .asDriver(onErrorRecover: { _ in fatalError("Encountered unexpected view model radio stations observable error.") })
            .drive(radioStationsData)
            .disposed(by: disposeBag)
        
        radioStationsData
            .asDriver(onErrorRecover: { _ in fatalError("Encountered unexpected radio stations observable error.") })
            .drive(onNext: { [weak self] _ in self?.reloadData() })
            .disposed(by: disposeBag)
    }
}

// MARK - UITableViewDataSource

extension AddRadioStationsRootTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try radioStationsData.value().count
        } catch {
            fatalError("Error reading value from list data subject.")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        do {
            let radioStation = try radioStationsData.value()[indexPath.row]
            
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

extension AddRadioStationsRootTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            let radioStationData = try radioStationsData.value()[indexPath.row]
            viewModel
                .didSelect(radioStationData)
        } catch {
            fatalError("Error reading value from list data subject.")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Helpers

private extension AddRadioStationsRootTableView {
    func configure(
        cell: UITableViewCell,
        with radioStationsData: AddRadioStationsData
    ) {
        
        guard let cell = cell as? AddRadioStationsRootTableViewCell else {
            return
        }
        
        cell.accessoryType = radioStationsData.isSelected ? .checkmark : .none
        cell.textLabel?.text = radioStationsData.radioStation.name
    }
}

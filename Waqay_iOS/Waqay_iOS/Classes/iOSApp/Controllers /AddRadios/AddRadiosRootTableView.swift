//
//  AddRadiosRootTableView.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/10/20.
//

import UIKit
import WaqayKit
import RxSwift
import PATools

class AddRadiosRootTableView: UITableView {
    
    fileprivate let radioCellIdentifier = "RadioCell"
    
    private unowned var viewModel: AddRadiosViewModel!
    
    private let disposeBag = DisposeBag()
    
    public func inject(viewModel: AddRadiosViewModel) {
        self.viewModel = viewModel
        
        self.delegate = self
        self.dataSource = self
        
        observeViewModel()
        viewModel.loadData()
    }
}

extension AddRadiosRootTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsIn(section)
    }
    
//    func tableView(_ tableView: UITableView,
//                   titleForHeaderInSection section: Int) -> String? {
//        viewModel.titleForHeaderIn(section)
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.radioCellIdentifier, for: indexPath)
        self.configure(cell: cell, for: indexPath)
        return cell
    }
}

private extension AddRadiosRootTableView {
    func configure(cell: UITableViewCell, for indexPath: IndexPath) {
        
        guard let cell = cell as? AddRadiosRootTableViewCell else {
            return
        }
        
        let radio = viewModel.object(at: indexPath)
        cell.textLabel?.text = radio.name
    }
}

extension AddRadiosRootTableView: UITableViewDelegate {
    
}

private extension AddRadiosRootTableView {
    
    private func observeViewModel() {
        let observable = viewModel.fetchedResultsControllerAction.distinctUntilChanged()
        subscribe(to: observable)
    }
    
    func subscribe(to observable: Observable<FetchedResultsControllerAction>) {
        observable.subscribe(onNext: { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.respond(to: action)
        }).disposed(by: disposeBag)
    }
    
    func respond(to action: FetchedResultsControllerAction) {
        switch action {
        case .willChangeContent:
            self.beginUpdates()
        case .didChangeContent:
            self.endUpdates()
        case .didChangeObject(let indexPath, let type, let newIndexPath):
            didChangeObject(at: indexPath, for: type, newIndexPath: newIndexPath)
        case .didChangeSection(let sectionIndex, let type):
            didChangeSection(atSectionIndex: sectionIndex, for: type)
        default:
            break
        }
    }
}

private extension AddRadiosRootTableView {
    
    func didChangeObject(at indexPath: IndexPath?,
                         for type: FetchedResultsControllerActionType,
                         newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            self.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            let cell = self.cellForRow(at: indexPath!)!
            configure(cell: cell, for: indexPath!)
        case .move:
            self.deleteRows(at: [indexPath!], with: .automatic)
            self.insertRows(at: [newIndexPath!], with: .automatic)
        }
    }
    
    func didChangeSection(atSectionIndex sectionIndex: Int,
                          for type: FetchedResultsControllerActionType) {
        let indexSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            self.insertSections(indexSet, with: .automatic)
        case .delete:
            self.deleteSections(indexSet, with: .automatic)
        default: break
        }
    }
}

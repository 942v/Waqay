//
//  AddRadiosViewModel.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import RxSwift
import CoreData
import PATools

public class AddRadiosViewModel: NSObject {
    
    private unowned let radiosDataRepository: RadiosDataRepository
    private unowned let didFinishAddingRadiosResponder: DidFinishAddingRadiosResponder
    
    public var view: Observable<AddRadiosView> {
        return viewSubject.asObservable()
    }
    private let viewSubject = BehaviorSubject<AddRadiosView>(value: .loading)
    
    public var fetchedResultsControllerAction: Observable<FetchedResultsControllerAction> {
        return _fetchedResultsControllerAction.asObservable()
    }
    private let _fetchedResultsControllerAction = BehaviorSubject<FetchedResultsControllerAction>(value: .none)

    public let doneButtonEnabled = BehaviorSubject<Bool>(value: false)
    
    lazy var fetchedResultsController: RichFetchedResultsController<Radio> = {
        func makeSortDescriptors() -> [NSSortDescriptor] {
            [
                NSSortDescriptor(key: #keyPath(Radio.section), ascending: false),
                NSSortDescriptor(key: #keyPath(Radio.name), ascending: true)
            ]
        }
        
        func makeFetchRequest() -> RichFetchRequest<Radio> {
            let fetchRequest = RichFetchRequest<Radio>(entityName: Radio.entityName)
            
            let sortDescriptors = makeSortDescriptors()
            fetchRequest.sortDescriptors = sortDescriptors
            
            fetchRequest.relationshipKeyPathsForRefreshing = [
                #keyPath(Radio.users)
            ]
            
            return fetchRequest
        }
        
        func objectContext() -> NSManagedObjectContext {
            let newChildContext = radiosDataRepository.mainContext()
            return newChildContext
        }
        
        let fetchedResultsController = RichFetchedResultsController<Radio>(
            fetchRequest: makeFetchRequest(),
            managedObjectContext: objectContext(),
            sectionNameKeyPath: #keyPath(Radio.section),
            cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    public init(radiosDataRepository: RadiosDataRepository,
                didFinishAddingRadiosResponder: DidFinishAddingRadiosResponder) {
        self.radiosDataRepository = radiosDataRepository
        self.didFinishAddingRadiosResponder = didFinishAddingRadiosResponder
    }
}

// MARK: - Actions
extension AddRadiosViewModel {
    
    public func didFinishAddingRadios() {
        didFinishAddingRadiosResponder.didFinishAddingRadios()
    }
    
    public func loadData() {
        performFetch()
        reloadData()
    }
    
    public func reloadData() {
        radiosDataRepository.updateRadios().catch { [weak self] error in
            guard let selfStrong = self else { return }
            let errorMessage = ErrorMessage(title: "Refreshing data error",
                                            message: error.localizedDescription)
            selfStrong.viewSubject.onNext(.failure(error: errorMessage))
        }
    }
    
    public func title() -> String {
        "Radio Stations"
    }
    
    public func numberOfSections() -> Int {
        fetchedResultsController.sections?.count ?? 0
    }
    
    public func numberOfRowsIn(_ section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController.sections?[section] else {
            return 0
        }
        
        return sectionInfo.numberOfObjects
    }
    
    public func titleForHeaderIn(_ section: Int) -> String? {
        let sectionInfo = fetchedResultsController.sections?[section]
        return sectionInfo?.name
    }
    
    public func object(at indexPath: IndexPath) -> Radio {
        fetchedResultsController.object(at: indexPath) as! Radio
    }
    
    public func didSelectRow(at indexPath: IndexPath) {
        
        _ = radiosDataRepository.currentUser().done { user in
            let radio = self.fetchedResultsController.object(at: indexPath) as! Radio
            let context = self.fetchedResultsController.managedObjectContext
            guard let selectedRadios = user.selectedRadios,
                !selectedRadios.contains(radio) else {
                    self.remove(radio, to: user, context: context)
                    return
            }
            self.add(radio, to: user, context: context)
        }
    }
}

private extension AddRadiosViewModel {
    private func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    }
    
    private func add(_ radio: Radio, to user: User, context: NSManagedObjectContext) {
        radio.addToUsers(user)
        user.addToSelectedRadios(radio)
        self.radiosDataRepository.save(context)
    }
    
    private func remove(_ radio: Radio, to user: User, context: NSManagedObjectContext) {
        radio.removeFromUsers(user)
        user.removeFromSelectedRadios(radio)
        self.radiosDataRepository.save(context)
    }
}

extension AddRadiosViewModel: NSFetchedResultsControllerDelegate {
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        _fetchedResultsControllerAction.onNext(.willChangeContent)
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                           didChange anObject: Any,
                           at indexPath: IndexPath?,
                           for type: NSFetchedResultsChangeType,
                           newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            _fetchedResultsControllerAction.onNext(.didChangeObject(indexPath: indexPath, type: .insert, newIndexPath: newIndexPath))
        case .delete:
            _fetchedResultsControllerAction.onNext(.didChangeObject(indexPath: indexPath, type: .delete, newIndexPath: newIndexPath))
        case .update:
            _fetchedResultsControllerAction.onNext(.didChangeObject(indexPath: indexPath, type: .update, newIndexPath: newIndexPath))
        case .move:
            _fetchedResultsControllerAction.onNext(.didChangeObject(indexPath: indexPath, type: .move, newIndexPath: newIndexPath))
        @unknown default:
            print("Unexpected NSFetchedResultsChangeType")
        }
    }
    
    public func controllerDidChangeContent(_ controller:NSFetchedResultsController<NSFetchRequestResult>) {
        if let fetchedObjectsCount = fetchedResultsController.fetchedObjects?.count,
            fetchedObjectsCount > 0 {
            viewSubject.onNext(.showingData)
        }
        doneButtonEnabled.onNext((fetchedResultsController.sections?.count ?? 0) > 1)
        _fetchedResultsControllerAction.onNext(.didChangeContent)
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                           didChange sectionInfo: NSFetchedResultsSectionInfo,
                           atSectionIndex sectionIndex: Int,
                           for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            _fetchedResultsControllerAction.onNext(.didChangeSection(sectionIndex: sectionIndex, type: .insert))
        case .delete:
            _fetchedResultsControllerAction.onNext(.didChangeSection(sectionIndex: sectionIndex, type: .delete))
        default: break
        }
    }
}

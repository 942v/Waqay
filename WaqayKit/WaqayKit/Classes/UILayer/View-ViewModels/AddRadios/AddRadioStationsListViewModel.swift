//
//  AddRadioStationsListViewModel.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import PromiseKit
import RxSwift

public class AddRadioStationsListViewModel: AddRadioStationsListViewModelInput {
    
    // MARK: - Properties
    private let repository: RadioStationsRepository
    private let didFinishAddingRadiosResponder: DidFinishAddingRadiosResponder
    
    // MARK: Rx
    public var view: Observable<AddRadiosView> {
        return viewSubject.asObservable()
    }
    private let viewSubject = BehaviorSubject<AddRadiosView>(value: .loading)
    public var errorMessages: Observable<WaqayError> {
        return errorMessagesSubject.asObservable()
    }
    private let errorMessagesSubject = PublishSubject<WaqayError>()

    public let doneButtonEnabled = BehaviorSubject<Bool>(value: false)
    
    public let radioStations = BehaviorSubject<[RadioStation]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    required public init(
        radioStationsRepository: RadioStationsRepository,
        didFinishAddingRadiosResponder: DidFinishAddingRadiosResponder
    ) {
        self.repository = radioStationsRepository
        self.didFinishAddingRadiosResponder = didFinishAddingRadiosResponder
        
        bindRepositoryToViewModel()
    }
    
    func bindRepositoryToViewModel() {
        
        repository
            .radioStations
            .asDriver(onErrorRecover: { _ in fatalError("Encountered unexpected repository radio stations observable error.") })
            .do(onNext: (didLoadRadioStations(radioStations:)))
            .drive(radioStations)
            .disposed(by: disposeBag)
    }
}

// MARK: - Actions
extension AddRadioStationsListViewModel {
    public func loadRadioStations() {
        repository
            .loadRadioStations()
            .catch { error in
                guard
                    let error = error as? WaqayError
                else {
                    fatalError("Error should be of type WaqayError")
                }
                self.errorMessagesSubject.onNext(error)
            }
    }
    
    public func didSelect(
        _ radioStation: RadioStation
    ) {
        
    }
    
    public func didFinishAddingRadios() {
        didFinishAddingRadiosResponder
            .didFinishAddingRadios()
    }
}

// MARK: - Helpers
extension AddRadioStationsListViewModel {
    func didLoadRadioStations(
        radioStations: [RadioStation]
    ) {
        if radioStations.count>0 {
            viewSubject.onNext(.showingData)
        }else{
            fatalError("TODO: Add support for showing view with no radios")
        }
    }
}

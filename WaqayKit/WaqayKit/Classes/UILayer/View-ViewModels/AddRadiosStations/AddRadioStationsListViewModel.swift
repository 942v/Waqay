//
//  AddRadioStationsListViewModel.swift
//  WaqayKit
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import PromiseKit
import RxSwift

public class AddRadioStationsListViewModel: AddRadioStationsListViewModelInput {
    
    // MARK: - Properties
    private let radioStationsRepository: RadioStationsRepository
    private let userInformationRepository: UserInformationRepository
    private let didFinishAddingRadiosResponder: DidFinishAddingRadiosResponder
    
    private var selectedRadioStations: [RadioStation]?
    
    // MARK: Rx
    public var view: Observable<AddRadioStationsView> {
        return viewSubject.asObservable()
    }
    private let viewSubject = BehaviorSubject<AddRadioStationsView>(value: .loading)
    public var errorMessages: Observable<WaqayError> {
        return errorMessagesSubject.asObservable()
    }
    private let errorMessagesSubject = PublishSubject<WaqayError>()
    
    public let doneButtonEnabled = BehaviorSubject<Bool>(value: false)
    
    public let radioStationsData = BehaviorSubject<[AddRadioStationsData]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    required public init(
        radioStationsRepository: RadioStationsRepository,
        userInformationRepository: UserInformationRepository,
        didFinishAddingRadiosResponder: DidFinishAddingRadiosResponder
    ) {
        self.radioStationsRepository = radioStationsRepository
        self.userInformationRepository = userInformationRepository
        self.didFinishAddingRadiosResponder = didFinishAddingRadiosResponder
        
        bindRepositoryToViewModel()
    }
    
    func bindRepositoryToViewModel() {
        
        radioStationsRepository
            .radioStations
            .asDriver(onErrorRecover: { _ in fatalError("Encountered unexpected repository radio stations observable error.") })
            .map(parseRadioStations)
            .do(onNext: (didLoadRadioStationsData(radioStationsData:)))
            .drive(radioStationsData)
            .disposed(by: disposeBag)
    }
}

// MARK: - Actions
extension AddRadioStationsListViewModel {
    public func loadRadioStations() {
        userInformationRepository
            .getUserInformation()
            .then { [weak self] (userInformation) -> Promise<Void> in
                guard let weakSelf = self else {
                    return .value
                }
                
                weakSelf.selectedRadioStations = userInformation.selectedRadioStations
                
                return weakSelf.radioStationsRepository
                    .loadRadioStations()
            }
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
        _ radioStationData: AddRadioStationsData
    ) {
        
        var allData = try! radioStationsData.value()
        let index = allData.firstIndex { $0 == radioStationData }!
        
        var radioStationData = radioStationData
        if radioStationData.isSelected {
            // Remove from selectedRadioStations
            selectedRadioStations?.removeAll(where: { $0 == radioStationData.radioStation })
            radioStationData.isSelected = false
        }else{
            // Add radio to selectedRadioStations
            selectedRadioStations?.append(radioStationData.radioStation)
            radioStationData.isSelected = true
        }
        
        allData[index] = radioStationData
        radioStationsData
            .onNext(allData)
    }
    
    public func didFinishAddingRadios() {
        userInformationRepository
            .updateUserInformation(
                selectedRadios: selectedRadioStations!
            )
            .done { [weak self] _ in
                self?.didFinishAddingRadiosResponder
                    .didFinishAddingRadios()
            }
            .catch { error in
                guard
                    let error = error as? WaqayError
                else {
                    fatalError("Error should be of type WaqayError")
                }
                self.errorMessagesSubject.onNext(error)
            }
    }
}

// MARK: - Helpers
extension AddRadioStationsListViewModel {
    
    func parseRadioStations(
        radioStations: [RadioStation]
    ) -> [AddRadioStationsData] {
        guard let selectedRadioStations = self.selectedRadioStations else {
            return []
        }
        
        return radioStations.reduce(into: []) { (result, radioStation) in
            let isSelected = selectedRadioStations.contains(radioStation)
            let addRadioStationsData = AddRadioStationsData(
                isSelected: isSelected,
                radioStation: radioStation
            )
            result.append(addRadioStationsData)
        }
    }
    
    func didLoadRadioStationsData(
        radioStationsData: [AddRadioStationsData]
    ) {
        if radioStationsData.count>0 {
            viewSubject.onNext(.showingData)
            doneButtonEnabled.onNext(true)
        }else{
            if try! viewSubject.value() != .loading {
                doneButtonEnabled.onNext(false)
                fatalError("TODO: Add support for showing view with no radios")
            }
        }
    }
}

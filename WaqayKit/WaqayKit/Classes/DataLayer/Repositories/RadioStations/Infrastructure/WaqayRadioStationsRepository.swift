//
//  WaqayRadioStationsRepository.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit
import RxSwift
import RxCocoa

public class WaqayRadioStationsRepository: RadioStationsRepository {
    
    // MARK: - Properties
    private let dataStore: RadioStationsDataStore
    private let provider: RadioStationsProvider
    
    // MARK: RX
    public let radioStations = BehaviorSubject<[RadioStation]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(
        dataStore: RadioStationsDataStore,
        provider: RadioStationsProvider
    ) {
        self.dataStore = dataStore
        self.provider = provider
        
        bindDataStoreToRepository()
    }
    
    func bindDataStoreToRepository() {
        
        dataStore
            .radioStations
            .asDriver(onErrorRecover: { _ in fatalError("Encountered unexpected data store radio stations observable error.") })
            .drive(radioStations)
            .disposed(by: disposeBag)
    }
}

extension WaqayRadioStationsRepository {
    
    public func loadRadioStations(
    ) -> Promise<Void> {
        return Promise<Bool> { seal in
            
            guard
                let radioStations = try? dataStore
                    .radioStations
                    .value() else {
                fatalError("User Roles need to be iniciated in the data store")
            }
            
            seal.fulfill(radioStations.count>0)
        }
        .then(fetchFromNetworkIfNeeded(hasRadioStations:))
    }
    
    func fetchFromNetworkIfNeeded(
        hasRadioStations: Bool = false
    ) -> Promise<Void> {
        
        guard !hasRadioStations else {
            return .value
        }
        
        return fetchFromNetworkIfNeeded()
    }
    
    func fetchFromNetworkIfNeeded(
    ) -> Promise<Void> {
        
        return provider
            .getRadioStations()
            .then(dataStore.save)
    }
}

//
//  WaqayUserInformationRepository.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit

class WaqayUserInformationRepository: UserInformationRepository {
    
    // MARK: - Properties
    private let dataStore: UserInformationDataStore
    private let provider: UserInformationProvider
    
    // MARK: - Methods
    init(
        dataStore: UserInformationDataStore,
        provider: UserInformationProvider
    ) {
        self.dataStore = dataStore
        self.provider = provider
    }
}

extension WaqayUserInformationRepository {
    
    func getUserInformation(
    ) -> Promise<UserInformation> {
        dataStore
            .getUserInformation()
            .then(fetchFromNetworkIfNeeded)
    }
    
    func updateUserInformation(
        selectedRadios: [RadioStation]
    ) -> Promise<UserInformation> {
        
        dataStore
            .getUserInformation()
            .then { userInformation -> Promise<UserInformation> in
                guard
                    let userInformation = userInformation
                else {
                    fatalError("We need a user information object to continue")
                }
                let newUserInformation = UserInformation(
                    identifier: userInformation.identifier,
                    selectedRadioStations: selectedRadios
                )
                return .value(newUserInformation)
            }
            .then(dataStore.save(_:))
    }
    
    func fetchFromNetworkIfNeeded(
        userInformationFromDataStore: UserInformation?
    ) -> Promise<UserInformation> {
        
        guard let userInformationFromDataStore = userInformationFromDataStore else {
            return provider
                .getUserInformation()
                .then(self.dataStore.save)
        }
        
        return .value(userInformationFromDataStore)
    }
}

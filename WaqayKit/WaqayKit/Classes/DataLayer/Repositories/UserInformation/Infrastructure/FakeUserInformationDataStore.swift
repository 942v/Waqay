//
//  FakeUserInformationDataStore.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit
import CocoaLumberjack

class FakeUserInformationDataStore: UserInformationDataStore {
    
    // MARK: - Properties
    private let hasUserInformation: Bool
    
    // MARK: - Methods
    init(
        hasUserInformation: Bool
    ) {
        self.hasUserInformation = hasUserInformation
    }
}

extension FakeUserInformationDataStore {
    
    func getUserInformation(
    ) -> Promise<UserInformation?> {
        switch hasUserInformation {
        case true:
            return runHasUserInformation()
        case false:
            return runDoesNotHaveUserInformation()
        }
    }
    
    func save(
        _ userInformation: UserInformation
    ) -> Promise<UserInformation> {
        .value(userInformation)
    }
}

fileprivate extension FakeUserInformationDataStore {
    
    func runHasUserInformation(
    ) -> Promise<UserInformation?> {
        DDLogInfo("Try to read user information from fake disk...")
        DDLogInfo("  simulating having user information with fake data...")
        DDLogInfo("  returning user information with fake data...")
        
        let identifier = UUID().uuidString
        
        let fakeRadioStationsDataStore = FakeRadioStationsDataStore(
            hasRadioStations: true
        )
        
        let selectedRadios = try! fakeRadioStationsDataStore.radioStations.value()
        
        let userInformation = UserInformation(
            identifier: identifier,
            selectedRadios: selectedRadios
        )
        
        return .value(userInformation)
    }
    
    func runDoesNotHaveUserInformation(
    ) -> Promise<UserInformation?> {
        DDLogInfo("Try to read user information from fake disk...")
        DDLogInfo("  simulating empty disk...")
        DDLogInfo("  returning empty...")
        return .value(nil)
    }
}


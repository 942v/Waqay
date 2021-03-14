//
//  UserInformationRepositoryFactory.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation

public class UserInformationRepositoryFactory {
    
    public class func userInformationRepository(
    ) -> UserInformationRepository {
        
        func makeDataStore() -> UserInformationDataStore {
//            FakeUserInformationDataStore(hasUserInformation: false)
            InMemoryUserInformationDataStore() 
            
//            let userInformationCoder = UserInformationPropertyListCoder()
//
//            return KeychainUserInformationDataStore(
//                userInformationCoder: userInformationCoder
//            )
        }
        
        func makeProvider() -> UserInformationProvider {
            LocalUserInformationProvider()
        }
        
        let dataStore = makeDataStore()
        let provider = makeProvider()
        
        return WaqayUserInformationRepository(
            dataStore: dataStore,
            provider: provider
        )
    }
}


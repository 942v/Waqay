//
//  InMemoryUserInformationDataStore.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit

class InMemoryUserInformationDataStore: UserInformationDataStore {
    
    // MARK: - Properties
    public var userInformation: UserInformation?
    fileprivate let accessQueue = DispatchQueue(label: "com.proatomicdev.waqay.userinformationdatastore.inmemorystore.access")
    
    // MARK: - Methods
    init() { }
}

extension InMemoryUserInformationDataStore {
    func getUserInformation(
    ) -> Promise<UserInformation?> {
        return Promise { seal in
            self.accessQueue.async {
                let userInformation = self.userInformation
                seal.fulfill(userInformation)
            }
        }
    }
    
    func save(
        _ userInformation: UserInformation
    ) -> Promise<UserInformation> {
        return Promise { seal in
            self.accessQueue.async {
                self.userInformation = userInformation
                seal.fulfill(userInformation)
            }
        }
    }
    
    func delete(
        userInformation: UserInformation
    ) -> Promise<UserInformation> {
        return Promise { seal in
            self.accessQueue.async {
                self.userInformation = nil
                seal.fulfill(userInformation)
            }
        }
    }
}

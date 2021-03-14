//
//  WaqayUserInformationDataStore.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit

class WaqayUserInformationDataStore: UserInformationDataStore {
    
    // MARK: - Properties
    public var userInformation: UserInformation?
    fileprivate let accessQueue = DispatchQueue(label: "com.proatomicdev.waqay.userinformationdatastore.inmemorystore.access")
    
    // MARK: - Methods
    init() { }
}

extension WaqayUserInformationDataStore {
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
}

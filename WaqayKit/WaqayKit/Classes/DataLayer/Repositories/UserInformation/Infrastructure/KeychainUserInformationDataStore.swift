//
//  KeychainUserInformationDataStore.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit
import KeychainAccess

fileprivate enum KeychainUserInformationDataStoreKeys: String {
    case userInformation
}

class KeychainUserInformationDataStore: UserInformationDataStore {
    
    // MARK: - Properties
    private let userInformationCoder: UserInformationCoding
    fileprivate let keychain = Keychain(service: "com.proatomicdev.waqay.userinformationdatastore.keychain.access")
    fileprivate let accessQueue = DispatchQueue(label: "com.proatomicdev.waqay.userinformationdatastore.inmemorystore.access")
    
    // MARK: - Methods
    init(
        userInformationCoder: UserInformationCoding
    ) {
        self.userInformationCoder = userInformationCoder
    }
}

extension KeychainUserInformationDataStore {
    func getUserInformation(
    ) -> Promise<UserInformation?> {
        return Promise { seal in
            self.accessQueue.async {
                self.readUserInformationSync(
                    seal: seal
                )
            }
        }
    }
    
    func save(
        _ userInformation: UserInformation
    ) -> Promise<UserInformation> {
        let data = userInformationCoder
            .encode(
                userInformation: userInformation
            )
        return self
            .getUserInformation()
            .map { userInformationFromKeychain -> UserInformation in
                try self.keychain.set(data, key: KeychainUserInformationDataStoreKeys.userInformation.rawValue)
                return userInformation
            }
    }
    
    public func delete(
        userInformation: UserInformation
    ) -> Promise<UserInformation> {
        return Promise<UserInformation> { seal in
            self.accessQueue.async {
                self.deleteSync(
                    userInformation: userInformation,
                    seal: seal
                )
            }
        }
    }
}

extension KeychainUserInformationDataStore {
    
    func readUserInformationSync(
        seal: Resolver<UserInformation?>
    ) {
        do {
            if let data = try keychain.getData(KeychainUserInformationDataStoreKeys.userInformation.rawValue) {
                let userInformation = self.userInformationCoder.decode(
                    data: data
                )
                seal.fulfill(userInformation)
            } else {
                seal.fulfill(nil)
            }
        } catch {
            seal.reject(error) // TODO: parse error into WaqayError
        }
    }
    
    func deleteSync(
        userInformation: UserInformation,
        seal: Resolver<UserInformation>
    ) {
        do {
            try keychain.remove(KeychainUserInformationDataStoreKeys.userInformation.rawValue)
            seal.fulfill(userInformation)
        } catch {
            seal.reject(error) // TODO: parse error into WaqayError
        }
    }
}

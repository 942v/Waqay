//
//  UserInformationDataStore.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit

protocol UserInformationDataStore {
    
    func getUserInformation(
    ) -> Promise<UserInformation?>
    func save(
        _ userInformation: UserInformation
    ) -> Promise<UserInformation>
}

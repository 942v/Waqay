//
//  LocalUserInformationProvider.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit

class LocalUserInformationProvider: UserInformationProvider {
}

extension LocalUserInformationProvider {
    
    func getUserInformation(
    ) -> Promise<UserInformation> {
        
        let userInformation = UserInformation(
            identifier: UUID().uuidString,
            selectedRadios: []
        )
        
        return .value(userInformation)
    }
}

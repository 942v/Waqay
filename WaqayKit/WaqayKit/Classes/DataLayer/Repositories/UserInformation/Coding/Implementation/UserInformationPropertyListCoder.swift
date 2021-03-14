//
//  UserInformationPropertyListCoder.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/14/21.
//

import Foundation

public class UserInformationPropertyListCoder: UserInformationCoding {
    
    // MARK: - Methods
    public init() {}
    
    public func encode(
        userInformation: UserInformation
    ) -> Data {
        return try! PropertyListEncoder().encode(userInformation)
    }
    
    public func decode(
        data: Data
    ) -> UserInformation {
        return try! PropertyListDecoder().decode(
            UserInformation.self,
            from: data
        )
    }
}

//
//  UserInformationCoding.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/14/21.
//

import Foundation

public protocol UserInformationCoding {
    
    func encode(userInformation: UserInformation) -> Data
    func decode(data: Data) -> UserInformation
}

//
//  UserInformationRepository.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit

public protocol UserInformationRepository {
   
   func getUserInformation(
   ) -> Promise<UserInformation>
}

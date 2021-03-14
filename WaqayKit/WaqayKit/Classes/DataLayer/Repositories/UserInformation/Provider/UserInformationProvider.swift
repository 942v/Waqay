//
//  UserInformationProvider.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import PromiseKit

protocol UserInformationProvider {
    func getUserInformation(
    ) -> Promise<UserInformation>
}

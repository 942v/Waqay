//
//  PushNotificationsRepository.swift
//  Pods
//
//  Created by Guillermo Sáenz on 5/17/20.
//

import Foundation
import PromiseKit

public protocol PushNotificationsRepository {
    
    func askForPushNotificationsPermission() -> Promise<Bool>
}

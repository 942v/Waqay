//
//  PushNotificationsService.swift
//  Pods
//
//  Created by Guillermo Sáenz on 5/17/20.
//

import Foundation
import PromiseKit

public protocol PushNotificationsService {
    func askForPushNotificationsPermission() -> Promise<Bool>
}

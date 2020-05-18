//
//  WaqayOneSignalPushNotificationsService.swift
//  Pods
//
//  Created by Guillermo Sáenz on 5/17/20.
//

import Foundation
import PromiseKit
import OneSignal

public class WaqayOneSignalPushNotificationsService: PushNotificationsService {
    
    public init() { }
    
    public func askForPushNotificationsPermission() -> Promise<Bool> {
        return Promise<Bool> { seal in
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                seal.fulfill(accepted)
            }, fallbackToSettings: true)
        }
    }
}

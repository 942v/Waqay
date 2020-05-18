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
    
    public func isNotificationPermissionAuthorized() -> Bool {
        guard let permissionStatus = OneSignal.getPermissionSubscriptionState()?.permissionStatus else {
            return false
        }
        
        return permissionStatus.status == .authorized
    }
    
    public func hasPromptedForPermission() -> Bool {
        guard let permissionStatus = OneSignal.getPermissionSubscriptionState()?.permissionStatus else {
            return false
        }
        
        return permissionStatus.status != .notDetermined
    }
    
    public func askForPushNotificationsPermission() -> Promise<Bool> {
        OneSignal.getPermissionSubscriptionState()
        
        return Promise<Bool> { seal in
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                seal.fulfill(accepted)
            }, fallbackToSettings: true)
        }
    }
    
    public func presentAppSettings() {
        OneSignal.presentAppSettings()
    }
}

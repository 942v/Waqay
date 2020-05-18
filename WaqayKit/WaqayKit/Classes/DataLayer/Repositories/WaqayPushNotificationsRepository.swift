//
//  WaqayPushNotificationsRepository.swift
//  Pods
//
//  Created by Guillermo Sáenz on 5/17/20.
//

import Foundation
import PromiseKit

public class WaqayPushNotificationsRepository {
    
    private let pushNotificationsServiceProvider: PushNotificationsService
    
    public init(pushNotificationsServiceProvider: PushNotificationsService) {
        self.pushNotificationsServiceProvider = pushNotificationsServiceProvider
    }
}

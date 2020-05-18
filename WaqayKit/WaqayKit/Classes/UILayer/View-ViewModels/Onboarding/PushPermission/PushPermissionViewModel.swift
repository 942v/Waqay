//
//  PushPermissionViewModel.swift
//  Pods
//
//  Created by Guillermo Sáenz on 5/17/20.
//

import Foundation

public class PushPermissionViewModel {
    
    private unowned let pushNotificationServiceProvider: PushNotificationsService
    private unowned let goToPlayerNavigator: GoToPlayerNavigator
    
    public init(pushNotificationServiceProvider: PushNotificationsService,
                goToPlayerNavigator: GoToPlayerNavigator) {
        self.pushNotificationServiceProvider = pushNotificationServiceProvider
        self.goToPlayerNavigator = goToPlayerNavigator
    }
}

// MARK: - Actions
extension PushPermissionViewModel {
    
    public func askForPermission() {
        if !pushNotificationServiceProvider.hasPromptedForPermission() {
            _ = pushNotificationServiceProvider.askForPushNotificationsPermission().done(didAnswerPermissionPrompt(accepted:))
        }else{
            #warning("TODO: Should show mesage saying that you should go to Settings")
            pushNotificationServiceProvider.presentAppSettings()
        }
    }
    
    public func showPlayer() {
        goToPlayerNavigator.navigateToPlayer()
    }
}

extension PushPermissionViewModel {
    
    func didAnswerPermissionPrompt(accepted: Bool) {
        showPlayer()    
    }
}

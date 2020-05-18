//
//  PushPermissionViewModel.swift
//  Pods
//
//  Created by Guillermo Sáenz on 5/17/20.
//

import Foundation

public class PushPermissionViewModel {
    
    private unowned let goToPlayerNavigator: GoToPlayerNavigator
    
    public init(pushServiceProvider: Any,
                goToPlayerNavigator: GoToPlayerNavigator) {
        self.goToPlayerNavigator = goToPlayerNavigator
    }
}

// MARK: - Actions
extension PushPermissionViewModel {
    
    public func showPlayer() {
        goToPlayerNavigator.navigateToPlayer()
    }
}

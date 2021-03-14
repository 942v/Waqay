//
//  SceneDelegate.swift
//  Waqay
//
//  Created by Guillermo Sáenz on 3/14/21.
//  Copyright © 2021 Property Atomic Strong SAC. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let injectionContainer = WaqayAppDependenciesContainer()
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let rootViewController = injectionContainer
            .makeMainViewController()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootViewController

        self.window = window
        window.makeKeyAndVisible()
    }
}

//
//  AppDelegate.swift
//  Waqay
//
//  Created by Guillermo Sáenz on 5/3/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import UIKit
import CocoaLumberjack
import OneSignal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let waqayAppDependenciesContainer = WaqayAppDependenciesContainer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureLogger()
        setupOneSignal(with: launchOptions)
        
        if #available(iOS 13, *) { } else {
            let mainViewController = waqayAppDependenciesContainer.makeMainViewController()
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()
            window?.rootViewController = mainViewController
        }
        
        return true
    }
}

extension AppDelegate {
    func setupOneSignal(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        #if DEBUG
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        #endif
        
        //START OneSignal initialization code
//        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: false]
//        
//        // Replace 'YOUR_ONESIGNAL_APP_ID' with your OneSignal App ID.
//        OneSignal.initWithLaunchOptions(launchOptions,
//                                        appId: APIKeys.osApiKey,
//                                        handleNotificationAction: nil,
//                                        settings: onesignalInitSettings)
//        
//        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
    }
}

fileprivate extension AppDelegate {
    func configureLogger() {
        let osLogger = DDOSLogger.sharedInstance
        DDLog.add(osLogger)
    }
}

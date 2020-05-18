//
//  WaqayOnboardingDependenciesContainer.swift
//  KeychainAccess
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//

import WaqayKit

public class WaqayOnboardingDependenciesContainer {
    
    private unowned let sharedRadiosDataRepository: RadiosDataRepository
    private unowned let sharedPushNotificationServiceProvider: PushNotificationsService
    private let sharedMainViewModel: MainViewModel
    private let sharedOnboardingViewModel: OnboardingViewModel
    
    public init(appDependencyContainer: WaqayAppDependenciesContainer) {
        
        func makeOnboardingViewModel(pushNotificationServiceProvider: PushNotificationsService,
                                     goToPlayerNavigator: GoToPlayerNavigator) -> OnboardingViewModel {
            
            return OnboardingViewModel(pushNotificationServiceProvider: pushNotificationServiceProvider,
                                       goToPlayerNavigator: goToPlayerNavigator)
        }
        
        self.sharedRadiosDataRepository = appDependencyContainer.sharedRadiosDataRepository
        self.sharedPushNotificationServiceProvider = appDependencyContainer.sharedPushNotificationServiceProvider
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
        self.sharedOnboardingViewModel = makeOnboardingViewModel(pushNotificationServiceProvider: sharedPushNotificationServiceProvider,
                                                                 goToPlayerNavigator: sharedMainViewModel)
    }
}

// MARK: - Onboarding
extension WaqayOnboardingDependenciesContainer {
    func makeOnboardingNavigationViewController() -> OnboardingNavigationViewController {
        let viewModel = sharedOnboardingViewModel
        let welcomeViewController = makeWelcomeViewController()
        
        let addRadiosViewControllerFactory = {
            return self.makeAddRadiosViewController()
        }
        
        let pushPermissionViewControllerFactory = {
            return self.makePushPermissionViewController()
        }
        
        return OnboardingNavigationViewController(viewModel: viewModel,
                                                  welcomeViewController: welcomeViewController,
                                                  makeAddRadiosViewController: addRadiosViewControllerFactory,
                                                  makePushPermissionViewController: pushPermissionViewControllerFactory)
    }
}

// MARK: - Welcome
extension WaqayOnboardingDependenciesContainer: WelcomeViewModelFactory {
    public func makeWelcomeViewModel() -> WelcomeViewModel {
        
        let viewModel = sharedOnboardingViewModel
        return WelcomeViewModel(goToAddRadiosNavigator: viewModel)
    }
    
    func makeWelcomeViewController() -> WelcomeViewController {
        
        let welcomeViewController = WelcomeViewController.instantiate(from: .welcomeStoryboard, framework: "Waqay_iOS")
        
        welcomeViewController.inject(welcomeViewModelFactory: self)
        
        return welcomeViewController
    }
}

extension WaqayOnboardingDependenciesContainer: AddRadiosViewModelFactory {
    public func makeAddRadiosViewModel() -> AddRadiosViewModel {
        let radiosDataRepository = sharedRadiosDataRepository
        let onboardingViewModel = sharedOnboardingViewModel
        
        return AddRadiosViewModel(radiosDataRepository: radiosDataRepository,
                                  didFinishAddingRadiosResponder: onboardingViewModel)
    }
    
    func makeAddRadiosViewController() -> AddRadiosTableViewController {
        
        let addRadiosTableViewController = AddRadiosTableViewController.instantiate(from: .addRadiosStoryboard, framework: "Waqay_iOS")
        
        addRadiosTableViewController.inject(viewModelFactory: self)
        
        return addRadiosTableViewController
    }
}

// MARk: - PushPermission
extension WaqayOnboardingDependenciesContainer: PushPermissionViewModelFactory {
    public func makePushPermissionViewModel() -> PushPermissionViewModel {
        let pushNotificationsService = sharedPushNotificationServiceProvider
        let mainViewModel = sharedMainViewModel
        
        return PushPermissionViewModel(pushNotificationServiceProvider: pushNotificationsService,
                                       goToPlayerNavigator: mainViewModel)
    }
    
    func makePushPermissionViewController() -> PushPermissionViewController {
        
        let pushPermissionViewController = PushPermissionViewController.instantiate(from: .pushPermissionStoryboard, framework: "Waqay_iOS")
        
        pushPermissionViewController.inject(pushPermissionViewModelFactory: self)
        
        return pushPermissionViewController
    }
}

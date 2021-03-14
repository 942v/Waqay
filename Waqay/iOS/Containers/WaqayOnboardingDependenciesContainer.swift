//
//  WaqayOnboardingDependenciesContainer.swift
//  KeychainAccess
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//

import WaqayKit

public class WaqayOnboardingDependenciesContainer {
    
    // MARK: - Properties
    
    // From parent container
    private let sharedUserInformationRepository: UserInformationRepository
    private let sharedRadioStationsRepository: RadioStationsRepository
    private unowned let sharedPushNotificationServiceProvider: PushNotificationsService
    private let sharedMainViewModel: MainViewModel
    
    // Longed-lived dependencies
    private let sharedOnboardingViewModel: OnboardingViewModel
    
    // MARK: - Methods
    public init(
        appDependencyContainer: WaqayAppDependenciesContainer
    ) {
        
        func makeOnboardingViewModel(
            pushNotificationServiceProvider: PushNotificationsService,
            goToPlayerNavigator: GoToPlayerNavigator
        ) -> OnboardingViewModel {
            
            return OnboardingViewModel(
                pushNotificationServiceProvider: pushNotificationServiceProvider,
                goToPlayerNavigator: goToPlayerNavigator
            )
        }
        
        self.sharedUserInformationRepository = appDependencyContainer.sharedUserInformationRepository
        self.sharedRadioStationsRepository = appDependencyContainer.sharedRadioStationsRepository
        self.sharedPushNotificationServiceProvider = appDependencyContainer.sharedPushNotificationServiceProvider
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
        self.sharedOnboardingViewModel = makeOnboardingViewModel(
            pushNotificationServiceProvider: sharedPushNotificationServiceProvider,
            goToPlayerNavigator: sharedMainViewModel
        )
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
        
        return OnboardingNavigationViewController(
            viewModel: viewModel,
            welcomeViewController: welcomeViewController,
            makeAddRadiosViewController: addRadiosViewControllerFactory,
            makePushPermissionViewController: pushPermissionViewControllerFactory
        )
    }
}

// MARK: - Welcome
extension WaqayOnboardingDependenciesContainer: WelcomeViewModelFactory {
    public func makeWelcomeViewModel() -> WelcomeViewModel {
        
        let viewModel = sharedOnboardingViewModel
        return WelcomeViewModel(
            goToAddRadiosNavigator: viewModel
        )
    }
    
    func makeWelcomeViewController() -> WelcomeViewController {
        
        let welcomeViewController = WelcomeViewController
            .instantiate(
                from: .welcomeStoryboard
            )
        
        welcomeViewController.inject(
            welcomeViewModelFactory: self
        )
        
        return welcomeViewController
    }
}

extension WaqayOnboardingDependenciesContainer: AddRadioStationsListViewModelFactory {
    public func makeAddRadioStationsListViewModel() -> AddRadioStationsListViewModelInput {
        let radioStationsRepository = sharedRadioStationsRepository
        let userInformationRepository = sharedUserInformationRepository
        let onboardingViewModel = sharedOnboardingViewModel
        
        return AddRadioStationsListViewModel(
            radioStationsRepository: radioStationsRepository,
            userInformationRepository: userInformationRepository,
            didFinishAddingRadiosResponder: onboardingViewModel
        )
    }
    
    func makeAddRadiosViewController() -> AddRadioStationsTableViewController {
        
        let addRadiosTableViewController = AddRadioStationsTableViewController.instantiate(
            from: .addRadioStationsStoryboard
        )
        
        addRadiosTableViewController.inject(
            viewModelFactory: self
        )
        
        return addRadiosTableViewController
    }
}

// MARk: - PushPermission
extension WaqayOnboardingDependenciesContainer: PushPermissionViewModelFactory {
    public func makePushPermissionViewModel() -> PushPermissionViewModel {
        let pushNotificationsService = sharedPushNotificationServiceProvider
        let mainViewModel = sharedMainViewModel
        
        return PushPermissionViewModel(
            pushNotificationServiceProvider: pushNotificationsService,
            goToPlayerNavigator: mainViewModel
        )
    }
    
    func makePushPermissionViewController() -> PushPermissionViewController {
        
        let pushPermissionViewController = PushPermissionViewController
            .instantiate(
                from: .pushPermissionStoryboard
            )
        
        pushPermissionViewController
            .inject(
                pushPermissionViewModelFactory: self
            )
        
        return pushPermissionViewController
    }
}

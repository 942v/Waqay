//
//  WaqayAppDependenciesContainer.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//

import WaqayKit

public class WaqayAppDependenciesContainer {
    
    let sharedUserInformationRepository: UserInformationRepository
    let sharedRadioStationsRepository: RadioStationsRepository
    let sharedPushNotificationServiceProvider: PushNotificationsService
    let sharedMainViewModel: MainViewModel
    
    public init() {
        
        self.sharedUserInformationRepository = UserInformationRepositoryFactory
            .userInformationRepository()
        
        func makeBaseURLProvider() -> BaseURLProvider {
            ApiaryURLProvider()
        }
        
        let baseURLProvider = makeBaseURLProvider()
        
        self.sharedRadioStationsRepository = RadioStationsRepositoryFactory.radioStationsRepository(
            baseURLProvider: baseURLProvider
        )
        
        func makePushNotificationsService() -> PushNotificationsService {
            return WaqayOneSignalPushNotificationsService()
        }
        
        self.sharedPushNotificationServiceProvider = makePushNotificationsService()
        
        func makeMainViewModel() -> MainViewModel {
            return MainViewModel()
        }
        
        self.sharedMainViewModel = makeMainViewModel()
    }
}

// MARK: - Main
extension WaqayAppDependenciesContainer {
    
    public func makeMainViewController() -> MainViewController {
        
        let mainViewModel = sharedMainViewModel
        let launchViewController = makeLaunchViewController()
        
        let onboardingViewControllerFactory = {
            return self.makeOnboardingNavigationViewController()
        }
        
        let mainViewController = MainViewController(
            viewModel: mainViewModel,
            launchViewController: launchViewController,
            onboardingNavigationViewControllerFactory: onboardingViewControllerFactory
        )
        
        return mainViewController
    }
}

// MARK: - Launch
extension WaqayAppDependenciesContainer: LaunchViewModelFactory {
    
    func makeLaunchViewController() -> LaunchViewController {
        let launchViewController = LaunchViewController
            .instantiate(
                from: .launchStoryboard
            )
        
        launchViewController.inject(
            launchViewModelFactory: self
        )
        
        return launchViewController
    }
    
    public func makeLaunchViewModel() -> LaunchViewModel {
        let userInformationRepository = sharedUserInformationRepository
        
        let mainViewModel = sharedMainViewModel
        
        return LaunchViewModel(
            userInformationRepository: userInformationRepository,
            noRadiosSelectedResponder: mainViewModel,
            hasRadiosSelectedResponder: mainViewModel
        )
    }
}

// MARK: - Onboarding
extension WaqayAppDependenciesContainer {
    func makeOnboardingNavigationViewController() -> OnboardingNavigationViewController {
        let onboardingDependenciesContainer = WaqayOnboardingDependenciesContainer(
            appDependencyContainer: self
        )
        return onboardingDependenciesContainer
            .makeOnboardingNavigationViewController()
    }
}




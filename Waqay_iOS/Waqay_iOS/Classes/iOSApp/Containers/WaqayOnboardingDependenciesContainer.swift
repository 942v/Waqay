//
//  WaqayOnboardingDependenciesContainer.swift
//  KeychainAccess
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//

import WaqayKit

public class WaqayOnboardingDependenciesContainer {
    
    private unowned let sharedRadiosDataRepository: RadiosDataRepository
    private let sharedOnboardingViewModel: OnboardingViewModel
    
    public init(appDependencyContainer: WaqayAppDependenciesContainer) {
        
        func makeOnboardingViewModel() -> OnboardingViewModel {
            return OnboardingViewModel()
        }
        
        self.sharedRadiosDataRepository = appDependencyContainer.sharedRadiosDataRepository
        self.sharedOnboardingViewModel = makeOnboardingViewModel()
    }
}

// MARK: - Onboarding
extension WaqayOnboardingDependenciesContainer {
    func makeOnboardingNavigationViewController() -> OnboardingNavigationViewController {
        let viewModel = sharedOnboardingViewModel
        let welcomeViewController = makeWelcomeViewController()
        
        return OnboardingNavigationViewController(viewModel: viewModel,
                                                  welcomeViewController: welcomeViewController)
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

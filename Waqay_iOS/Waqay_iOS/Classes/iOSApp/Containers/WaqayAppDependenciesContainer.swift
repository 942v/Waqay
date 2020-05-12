//
//  WaqayAppDependenciesContainer.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//

import WaqayKit

public class WaqayAppDependenciesContainer {
    
    let sharedRadiosDataRepository: WaqayRadiosDataRepository
    let sharedMainViewModel: MainViewModel
    
    public init() {
        
        func makeRadiosDataStore() -> RadiosDataStore {
            func makeCoreDataStack() -> CoreDataStack {
//                CoreDataStack(with: "WaqayData")
                InMemoryCoreDataStack(with: "WaqayData")
            }
            return WaqayCoreDataRadiosDataStore(with: makeCoreDataStack())
        }
        
        func makeRadiosDataRemoteAPI() -> RadiosDataRemoteAPI {
//            return WaqayFakeRadiosRemoteDataAPI()
            return WaqayRadiosRemoteDataAPI()
        }
        
        func makeRadiosDataRepository() -> WaqayRadiosDataRepository {
            let radiosDataStore = makeRadiosDataStore()
            let radiosDataRemoteAPI = makeRadiosDataRemoteAPI()
            
            return WaqayRadiosDataRepository(radiosDataStore: radiosDataStore,
                                             radiosDataRemoteAPI: radiosDataRemoteAPI)
        }
        
        self.sharedRadiosDataRepository = makeRadiosDataRepository()
        
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
        
        let mainViewController = MainViewController(viewModel: mainViewModel,
                                                    launchViewController: launchViewController,
                                                    onboardingNavigationViewControllerFactory: onboardingViewControllerFactory)
        
        return mainViewController
    }
}

// MARK: - Launch
extension WaqayAppDependenciesContainer: LaunchViewModelFactory {
    
    func makeLaunchViewController() -> LaunchViewController {
        let launchViewController = LaunchViewController.instantiate(from: .launchStoryboard, framework: "Waqay_iOS")
        
        launchViewController.inject(launchViewModelFactory: self)
        
        return launchViewController
    }
    
    public func makeLaunchViewModel() -> LaunchViewModel {
        let radiosDataRepository = sharedRadiosDataRepository
        
        let mainViewModel = sharedMainViewModel
        
        return LaunchViewModel(radiosDataRepository: radiosDataRepository,
                               noRadiosSelectedResponder: mainViewModel,
                               hasRadiosSelectedResponder: mainViewModel)
    }
}

// MARK: - Onboarding
extension WaqayAppDependenciesContainer {
    func makeOnboardingNavigationViewController() -> OnboardingNavigationViewController {
        let onboardingDependenciesContainer = WaqayOnboardingDependenciesContainer(appDependencyContainer: self)
        return onboardingDependenciesContainer.makeOnboardingNavigationViewController()
    }
}




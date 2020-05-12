//
//  MainViewController.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import UIKit
import WaqayKit
import RxSwift
import PATools

public typealias OnboardingNavigationViewControllerFactory = () ->  OnboardingNavigationViewController

public class MainViewController: NiblessViewController {
    
    // MARK: - Properties
    // ViewModel
    private unowned let viewModel: MainViewModel
    
    // ViewControllers
    private let launchViewController: LaunchViewController
    
    // State
    private let disposeBag = DisposeBag()
    
    // Factories
    private let makeOnboardingNavigationViewController: OnboardingNavigationViewControllerFactory
    
    // MARK: - Methods
    init(viewModel: MainViewModel,
         launchViewController: LaunchViewController,
         onboardingNavigationViewControllerFactory: @escaping OnboardingNavigationViewControllerFactory) {
        self.viewModel = viewModel
        self.launchViewController = launchViewController
        self.makeOnboardingNavigationViewController = onboardingNavigationViewControllerFactory
        super.init()
    }
    
    func subscribe(to observable: Observable<MainView>) {
        observable.subscribe(onNext: { [weak self] view in
            guard let strongSelf = self else { return }
            strongSelf.present(view)
        }).disposed(by: disposeBag)
    }
    
    func present(_ view: MainView) {
        switch view {
        case .launching:
            presentLaunchViewController()
        case .onboarding:
            presentOnboardingNavigationViewController()
        case .player:
            // present player
            print("Should show player")
        }
    }
    
    func presentLaunchViewController() {
        addFullScreen(childViewController: launchViewController)
    }
    
    func presentOnboardingNavigationViewController() {
        let onboardingNavigationViewController = makeOnboardingNavigationViewController()
        onboardingNavigationViewController.modalPresentationStyle = .fullScreen
        present(onboardingNavigationViewController, animated: true) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.remove(childViewController: strongSelf.launchViewController)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        observeViewModel()
    }

    private func observeViewModel() {
      let observable = viewModel.view.distinctUntilChanged()
      subscribe(to: observable)
    }
}

//
//  OnboardingNavigationViewController.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import UIKit
import WaqayKit
import RxSwift

public class OnboardingNavigationViewController: UINavigationController {
    
    // MARK: - Properties
    // ViewModel
    private let viewModel: OnboardingViewModel
    
    // ViewControllers
    private let welcomeViewController: WelcomeViewController
    
    // Storage
    private let disposeBag = DisposeBag()

    // MARK: - Methods
    init(viewModel: OnboardingViewModel,
        welcomeViewController: WelcomeViewController) {
        self.viewModel = viewModel
        self.welcomeViewController = welcomeViewController
        
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func subscribe(to observable: Observable<OnboardingNavigationAction>) {
        observable.subscribe(onNext: { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.respond(to: action)
        }).disposed(by: disposeBag)
    }
    
    func respond(to action: OnboardingNavigationAction) {
        switch action {
        case .present(let view):
            present(view)
        case .presented:
            break
        }
    }
    
    func present(_ view: OnboardingView) {
        switch view {
        case .welcome:
            presentWelcomeViewController()
        case .addRadios:
            // present player
            print("Should show addRadios")
        }
    }
    
    func presentWelcomeViewController() {
        pushViewController(welcomeViewController, animated: false)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        observeViewModel()
    }

    private func observeViewModel() {
        let observable = viewModel.navigationAction.distinctUntilChanged()
      subscribe(to: observable)
    }
}

extension OnboardingNavigationViewController {
    func hideOrShowNavigationBarIfNeeded(for view: OnboardingView, animated: Bool) {
      if view.shouldHideNavigationBar() {
        hideNavigationBar(animated: animated)
      } else {
        showNavigationBar(animated: animated)
      }
    }

    func hideNavigationBar(animated: Bool) {
      if animated {
        transitionCoordinator?.animate(alongsideTransition: { context in
          self.setNavigationBarHidden(true, animated: animated)
        })
      } else {
        setNavigationBarHidden(true, animated: false)
      }
    }

    func showNavigationBar(animated: Bool) {
      if self.isNavigationBarHidden {
        self.setNavigationBarHidden(false, animated: animated)
      }
    }
}

extension OnboardingNavigationViewController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let viewThatWillShow = onboardingView(associatedWith: viewController) else {return}
        hideOrShowNavigationBarIfNeeded(for: viewThatWillShow, animated: animated)
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let viewThatDidShow = onboardingView(associatedWith: viewController) else {return}
        viewModel.uiPresented(onboardingView: viewThatDidShow)
    }
}

private extension OnboardingNavigationViewController {
    func onboardingView(associatedWith viewController: UIViewController) -> OnboardingView? {
      switch viewController {
      case is WelcomeViewController:
        return .welcome
//      case is Add:
//        return .addRadios
      default:
        assertionFailure("Encountered unexpected child view controller type in OnboardingViewController")
        return nil
      }
    }
}

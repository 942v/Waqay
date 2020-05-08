//
//  OnboardingViewModel.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import RxSwift

public typealias OnboardingNavigationAction = NavigationAction<OnboardingView>

public class OnboardingViewModel {

    public var navigationAction: Observable<OnboardingNavigationAction> {
      return _navigationAction.asObservable()
    }
    private let _navigationAction = BehaviorSubject<OnboardingNavigationAction>(value: .present(view: .welcome))
}

// MARK: - Actions
extension OnboardingViewModel {
    public func uiPresented(onboardingView: OnboardingView) {
      _navigationAction.onNext(.presented(view: onboardingView))
    }
}

// MARK: - GoToAddRadiosNavigator
extension OnboardingViewModel: GoToAddRadiosNavigator {
    public func navigateToAddRadios() {
        _navigationAction.onNext(.present(view: .addRadios))
    }
}

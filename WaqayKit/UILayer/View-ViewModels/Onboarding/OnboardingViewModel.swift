//
//  OnboardingViewModel.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import RxSwift

public class OnboardingViewModel {
    
    public var view: Observable<OnboardingView> {
        return viewSubject.asObservable()
    }
    private let viewSubject = BehaviorSubject<OnboardingView>(value: .welcome)
}

// MARK: - AddRadiosResponder
extension OnboardingViewModel: AddRadiosNavigator {
    
}

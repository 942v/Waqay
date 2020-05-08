//
//  MainViewModel.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import RxSwift

public class MainViewModel {
    
    public var view: Observable<MainView> {
        return viewSubject.asObservable()
    }
    private let viewSubject = BehaviorSubject<MainView>(value: .launching)
}

// MARK: - NoRadiosSelectedResponder
extension MainViewModel: NoRadiosSelectedResponder {
    
}

// MARK: - HasRadiosSelectedResponder
extension MainViewModel: HasRadiosSelectedResponder {
    
}

// MARK: - GoToPlayerNavigator
extension MainViewModel: GoToPlayerNavigator {
    public func navigateToPlayer() {
        
    }
}

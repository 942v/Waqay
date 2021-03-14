//
//  WelcomeViewModelFactory.swift
//  KeychainAccess
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//

import WaqayKit

public protocol WelcomeViewModelFactory {
    
    func makeWelcomeViewModel() -> WelcomeViewModel
}

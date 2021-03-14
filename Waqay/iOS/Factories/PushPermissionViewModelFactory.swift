//
//  PushPermissionViewModelFactory.swift
//  Waqay
//
//  Created by Guillermo Sáenz on 5/17/20.
//

import WaqayKit

public protocol PushPermissionViewModelFactory {
    
    func makePushPermissionViewModel() -> PushPermissionViewModel
}

//
//  RadiosDataRepository.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import Foundation
import PromiseKit

public protocol RadiosDataRepository: AnyObject {
    
    func hasRadiosSelected() -> Promise<Bool>
}

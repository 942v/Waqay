//
//  RadiosDataRepository.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import Foundation
import PromiseKit
import CoreData

public protocol RadiosDataRepository: AnyObject {
    
    func currentUser() -> Promise<User>
    func hasRadiosSelected() -> Promise<Bool>
    func updateRadios() -> Promise<Bool>
    func mainContext() -> NSManagedObjectContext
    func newChildContext() -> NSManagedObjectContext
    func save(_ context: NSManagedObjectContext)
}

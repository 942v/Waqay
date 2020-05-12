//
//  RadiosDataStore.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//

import Foundation
import PromiseKit
import CoreData

public protocol RadiosDataStore {
    func readUser() -> Promise<User>
    func update(radiosData: [RadioData]) -> Promise<Bool>
    func mainContext() -> NSManagedObjectContext
}

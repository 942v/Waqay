//
//  RadiosDataStore.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//

import Foundation
import PromiseKit

public protocol RadiosDataStore {
    func readUser() -> Promise<User>
}

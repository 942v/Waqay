//
//  WaqayRadiosDataRepository.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/7/20.
//  Copyright © 2020 Property Atomic Strong SAC. All rights reserved.
//

import Foundation
import PromiseKit
import CoreData

public class WaqayRadiosDataRepository {
    
    private let radiosDataStore: RadiosDataStore
    private let radiosDataRemoteAPI: RadiosDataRemoteAPI
    
    public init(radiosDataStore: RadiosDataStore,
                radiosDataRemoteAPI: RadiosDataRemoteAPI) {
        self.radiosDataStore = radiosDataStore
        self.radiosDataRemoteAPI = radiosDataRemoteAPI
    }
}

extension WaqayRadiosDataRepository: RadiosDataRepository {
    
    public func currentUser() -> Promise<User> {
        radiosDataStore.readUser()
    }
    
    public func hasRadiosSelected() -> Promise<Bool> {
        radiosDataStore.readUser().then(hasRadiosSelected(user:))
    }
    
    public func updateRadios() -> Promise<Bool> {
        radiosDataRemoteAPI.getRadiosData().then(radiosDataStore.update(radiosData:))
    }
    
    public func mainContext() -> NSManagedObjectContext {
        radiosDataStore.mainContext()
    }
    
    public func newChildContext() -> NSManagedObjectContext {
        radiosDataStore.newChildContext()
    }
    
    public func save(_ context: NSManagedObjectContext) {
        radiosDataStore.save(context)
    }
}

private extension WaqayRadiosDataRepository {
    
    func hasRadiosSelected(user: User) -> Promise<Bool> {
        return Promise<Bool> { seal in
            guard let selectedRadios = user.selectedRadios else {
                seal.fulfill(false)
                return
            }
            seal.fulfill(selectedRadios.count>0)
        }
    }
}

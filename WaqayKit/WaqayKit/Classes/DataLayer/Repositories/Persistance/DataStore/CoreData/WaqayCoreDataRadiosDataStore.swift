//
//  WaqayCoreDataRadiosDataStore.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/9/20.
//

import Foundation
import CoreData
import PromiseKit

public class WaqayCoreDataRadiosDataStore {
    
    lazy var coreDataStack: CoreDataStack = {
        CoreDataStack(modelName: "WaqayData")
    }()
    
    public init() {}
}

extension WaqayCoreDataRadiosDataStore: RadiosDataStore {
    public func readUser() -> Promise<User> {
        return Promise<User> { seal in
            readUserSync(seal: seal)
        }
    }
}

private extension WaqayCoreDataRadiosDataStore {
    func makeUserFetchRequest() -> NSFetchRequest<User> {
        let fetchRequest = NSFetchRequest<User>(entityName: User.name)
        return fetchRequest
    }
    
    func readUserSync(seal: Resolver<User>) {
        let userFetchRequest = makeUserFetchRequest()
        do {
            let userFetchResult = try coreDataStack.managedContext.fetch(userFetchRequest)
            guard let user = userFetchResult.first else {
                createUserSync(seal: seal)
                return
            }
            seal.fulfill(user)
        } catch let error {
            seal.reject(error)
        }
    }
    
    func createUserSync(seal: Resolver<User>) {
        let user = User(context: coreDataStack.managedContext)
        coreDataStack.saveContext()
        seal.fulfill(user)
    }
}

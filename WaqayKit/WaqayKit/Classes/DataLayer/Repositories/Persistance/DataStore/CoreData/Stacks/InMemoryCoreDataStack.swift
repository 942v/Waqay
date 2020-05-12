//
//  InMemoryCoreDataStack.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/10/20.
//

import Foundation
import CoreData

public class InMemoryCoreDataStack: CoreDataStack {
    public override init(with modelName: String) {
        super.init(with: modelName)
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        self.storeContainer = container
    }
}

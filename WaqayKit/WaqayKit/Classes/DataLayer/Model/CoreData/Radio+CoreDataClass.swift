//
//  Radio+CoreDataClass.swift
//  
//
//  Created by Guillermo Sáenz on 5/18/20.
//
//

import Foundation
import CoreData

@objc(Radio)
public class Radio: NSManagedObject {
    
    @objc var section: String? {
        let notSelected = "Not selected"
        guard let usersCount = users?.count,
            usersCount > 0 else {
                return notSelected
        }
        
        return "Selected"
    }
}

//
//  WaqayFakeRadiosDataStore.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/8/20.
//

import Foundation
import PromiseKit

public class WaqayFakeRadiosDataStore {
    private let hasSelectedRadios: Bool
    
    public init(hasSelectedRadios: Bool) {
        self.hasSelectedRadios = hasSelectedRadios
    }
}

extension WaqayFakeRadiosDataStore: RadiosDataStore {
    public func readUser() -> Promise<User> {
        let user = User()
        user.addToSelectedRadios(makeSelectedRadios())
        return Promise<User> { seal in
            seal.fulfill(user)
        }
    }
    
    func makeSelectedRadios() -> NSSet {
        if hasSelectedRadios {
            let radio = Radio()
            return NSSet(array: [radio])
        }else{
            return NSSet()
        }
    }
}

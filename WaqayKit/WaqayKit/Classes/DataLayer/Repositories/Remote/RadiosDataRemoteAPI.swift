//
//  RadiosDataRemoteAPI.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/9/20.
//

import Foundation
import PromiseKit

public protocol RadiosDataRemoteAPI {
    func getRadiosData() -> Promise<[RadioData]>
}

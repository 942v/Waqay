//
//  BaseURLProvider.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation

public protocol BaseURLProvider {
    func baseURLComponent(
        appendingPath path: String?
    ) -> URLComponents
}

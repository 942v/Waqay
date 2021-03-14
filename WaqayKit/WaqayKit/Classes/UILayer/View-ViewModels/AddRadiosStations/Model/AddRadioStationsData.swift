//
//  AddRadioStationsData.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/14/21.
//

import Foundation

public struct AddRadioStationsData {
    public var isSelected: Bool
    public let radioStation: RadioStation
}

extension AddRadioStationsData: Equatable { }

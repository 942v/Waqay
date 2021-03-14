//
//  AddRadioStationsView.swift
//  Pods
//
//  Created by Guillermo Sáenz on 5/16/20.
//

import Foundation

public enum AddRadioStationsView {
    
    case loading
    case showingData
    case failure(error: WaqayError)
}

extension AddRadioStationsView: Equatable {
    
    public static func == (lhs: AddRadioStationsView, rhs: AddRadioStationsView) -> Bool {
        switch (lhs, rhs) {
        case (loading, .loading):
            return true
        case (showingData, .showingData):
            return true
        default:
            return false
        }
    }
}


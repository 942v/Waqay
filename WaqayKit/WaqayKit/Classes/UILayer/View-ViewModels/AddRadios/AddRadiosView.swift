//
//  AddRadiosView.swift
//  Pods
//
//  Created by Guillermo Sáenz on 5/16/20.
//

import Foundation

public enum AddRadiosView {
    
    case loading
    case showingData
    case failure(error: WaqayError)
}

extension AddRadiosView: Equatable {
    
    public static func == (lhs: AddRadiosView, rhs: AddRadiosView) -> Bool {
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


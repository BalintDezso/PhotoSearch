//
//  ModelError.swift
//  Model
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import Foundation

public enum ModelError: Error {
    
    case conversionFailure(details: String)
}

extension ModelError: LocalizedError {
    
    public var errorDescription: String? {
        
        switch self {
        case .conversionFailure(let details):
            return "Details: \(details)"
        }
    }
}

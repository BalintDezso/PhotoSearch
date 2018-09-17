//
//  ServiceError.swift
//  Service
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import Foundation

public enum ServiceError: Error {
    
    case invalidURL(details: String)
    case missingDataWhereExpected(details: String)
}

extension ServiceError: LocalizedError {
    
    public var errorDescription: String? {
        
        switch self {
        case .invalidURL(let details):
            return "Failed creating valid URL with details: \(details)"
        case .missingDataWhereExpected(let details):
            return "Found no data where it was expected with details: \(details)"
        }
    }
}

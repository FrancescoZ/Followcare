//
//  Error.swift
//  Follocare
//
//  Created by Francesco Zanoli on 06/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

import Foundation

public struct InstagramError: Error {
    
    // MARK: - Properties
    
    let kind: ErrorKind
    let message: String
    
    /// Retrieve the localized description for this error.
    public var localizedDescription: String {
        return "[\(kind.description)] - \(message)"
    }
    
    // MARK: - Types
    
    enum ErrorKind: CustomStringConvertible {
        case invalidRequest
        case jsonParseError
        case keychainError(code: OSStatus)
        case missingClient
        
        var description: String {
            switch self {
            case .invalidRequest:
                return "invalidRequest"
            case .jsonParseError:
                return "jsonParseError"
            case .keychainError(let code):
                return "keychainError(code: \(code)"
            case .missingClient:
                return "missingClient"
            }
        }
    }
    
}

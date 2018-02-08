//
//  ArrayExtension.swift
//  Follocare
//
//  Created by Francesco Zanoli on 06/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

extension Array where Element:InstagramScope {
    
    func joined(separator: String) -> String {
        return self.map({ "\($0.rawValue)" }).joined(separator: separator)
    }
    
}

//
//  Tag.swift
//  Follocare
//
//  Created by Francesco Zanoli on 06/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

public struct InstagramTag: Decodable {
    
    // MARK: - Properties
    
    /// The tag name.
    public let name: String
    
    /// The number of media in which the tag appears.
    public let mediaCount: Int
    
    // MARK: - Types
    
    private enum CodingKeys: String, CodingKey {
        case name
        case mediaCount = "media_count"
    }
    
}

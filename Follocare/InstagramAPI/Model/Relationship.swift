//
//  Relationship.swift
//  Follocare
//
//  Created by Francesco Zanoli on 06/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

/// The struct containing an Instagram relationship.

public struct InstagramRelationship: Decodable {
    
    // MARK: - Properties
    
    /// Your relationship to the user. It can be "follows", "requested" or "none".
    public let outgoingStatus: String
    
    /// A user's relationship to you. It can be "followed_by", "requested_by", "blocked_by_you" or "none".
    public let incomingStatus: String?
    
    // MARK: - Types
    
    private enum CodingKeys: String, CodingKey {
        case outgoingStatus = "outgoing_status"
        case incomingStatus = "incoming_status"
    }
    
}

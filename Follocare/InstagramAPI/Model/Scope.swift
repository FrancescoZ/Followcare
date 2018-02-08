//
//  Scope.swift
//  Follocare
//
//  Created by Francesco Zanoli on 06/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

public enum InstagramScope: String {
    
    /// To read a user’s profile info and media.
    case basic
    
    /// To read any public profile info and media on a user’s behalf.
    case publicContent = "public_content"
    
    /// To read the list of followers and followed-by users.
    case followerList = "follower_list"
    
    /// To post and delete comments on a user’s behalf.
    case comments
    
    /// To follow and unfollow accounts on a user’s behalf.
    case relationships
    
    /// To like and unlike media on a user’s behalf.
    case likes
    
}

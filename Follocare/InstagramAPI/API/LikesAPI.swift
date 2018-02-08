//
//  LikesAPI.swift
//  Follocare
//
//  Created by Francesco Zanoli on 06/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//


extension InstagramAPI {
    
    // MARK: - Like Endpoints
    
    /// Get a list of users who have liked this media.
    ///
    /// - parameter mediaId: The ID of the media object to reference.
    /// - parameter success: The callback called after a correct retrieval.
    /// - parameter failure: The callback called after an incorrect retrieval.
    ///
    /// - important: It requires *public_content* scope for media that does not belong to your own user.
    
    public func likes(inMedia mediaId: String, success: SuccessHandler<[InstagramUser]>?, failure: FailureHandler?) {
        request("/media/\(mediaId)/likes", success: success, failure: failure)
    }
    
    /// Set a like on this media by the currently authenticated user.
    ///
    /// - parameter mediaId: The ID of the media object to reference.
    /// - parameter failure: The callback called after an incorrect like.
    ///
    /// - important: It requires *likes* scope. Also, *public_content* scope is required for media that does not belong
    ///   to your own user.
    
    public func like(media mediaId: String, failure: FailureHandler?) {
        request("/media/\(mediaId)/likes", method: .post, success: { (_: InstagramResponse<Any?>) in return }, failure: failure)
    }
    
    /// Remove a like on this media by the currently authenticated user.
    ///
    /// - parameter Parameter mediaId: The ID of the media object to reference.
    /// - parameter failure: The callback called after an incorrect deletion.
    ///
    /// - important: It requires *likes* scope. Also, *public_content* scope is required for media that does not belong
    ///   to your own user.
    
    public func unlike(media mediaId: String, failure: FailureHandler?) {
        request("/media/\(mediaId)/likes", method: .delete, success: { (_: InstagramResponse<Any?>) in return }, failure: failure)
    }
    
}


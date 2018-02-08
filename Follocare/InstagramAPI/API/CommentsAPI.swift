//
//  CommentsAPI.swift
//  Follocare
//
//  Created by Francesco Zanoli on 06/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//


extension InstagramAPI {
    
    // MARK: - Comment Endpoints
    
    /// Get a list of recent comments on a media object.
    ///
    /// - parameter Parameter mediaId: The ID of the media object to reference.
    /// - parameter success: The callback called after a correct retrieval.
    /// - parameter failure: The callback called after an incorrect retrieval.
    ///
    /// - important: It requires *public_content* scope for media that does not belong to your own user.
    
    public func comments(fromMedia mediaId: String, success: SuccessHandler<[InstagramComment]>?, failure: FailureHandler?) {
        request("/media/\(mediaId)/comments", success: success, failure: failure)
    }
    
    /// Create a comment on a media object.
    ///
    /// - parameter mediaId: The ID of the media object to reference.
    /// - parameter text: Text to post as a comment on the media object as specified in `mediaId`.
    /// - parameter failure: The callback called after an incorrect creation.
    ///
    /// - important: It requires *comments* scope. Also, *public_content* scope is required for media that does not
    ///   belong to your own user.
    ///
    /// - note:
    ///     - The total length of the comment cannot exceed 300 characters.
    ///     - The comment cannot contain more than 4 hashtags.
    ///     - The comment cannot contain more than 1 URL.
    ///     - The comment cannot consist of all capital letters.
    
    public func createComment(onMedia mediaId: String, text: String, failure: FailureHandler?) {
        var parameters = Parameters()
        
        parameters["text"] = text
        
        request("/media/\(mediaId)/comments", method: .post, parameters: parameters, success: { (_: InstagramResponse<Any?>) in return }, failure: failure)
    }
    
    /// Remove a comment either on the authenticated user's media object or authored by the authenticated user.
    ///
    /// - parameter commentId: The ID of the comment to delete.
    /// - parameter mediaId: The ID of the media object to reference.
    /// - parameter failure: The callback called after an incorrect deletion.
    ///
    /// - important: It requires *comments* scope. Also, *public_content* scope is required for media that does not
    ///   belong to your own user.
    
    public func deleteComment(_ commentId: String, onMedia mediaId: String, failure: FailureHandler?) {
        request("/media/\(mediaId)/comments/\(commentId)", method: .delete, success: { (_: InstagramResponse<Any?>) in return }, failure: failure)
    }
    
}


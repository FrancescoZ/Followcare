//
//  Response.swift
//  Follocare
//
//  Created by Francesco Zanoli on 06/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//
struct InstagramResponse<T: Decodable>: Decodable {
    
    // MARK: - Properties
    
    let data: T?
    let meta: Meta
    let pagination: Pagination?
    
    // MARK: - Types
    
    struct Meta: Decodable {
        let code: Int
        let errorType: String?
        let errorMessage: String?
        
        private enum CodingKeys: String, CodingKey {
            case code
            case errorType = "error_type"
            case errorMessage = "error_message"
        }
    }
    
    struct Pagination: Decodable {
        let nextURL: String?
        let nextMaxId: String?
        
        private enum CodingKeys: String, CodingKey {
            case nextURL = "next_url"
            case nextMaxId = "next_max_id"
        }
    }
    
}

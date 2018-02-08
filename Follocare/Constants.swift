//
//  Constants.swift
//  Follocare
//
//  Created by Francesco Zanoli on 06/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

import Foundation

struct API{
    static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
    static let INSTAGRAM_CLIENT_ID = "c809329a49ff48879a9c591b5c7f05f7"
    static let INSTAGRAM_CLIENTSERCRET = "6965e7b6cd3c4adb86587c626ddbde08"
    static let INSTAGRAM_REDIRECT_URI = "https://www.follocare.com"
    static let INSTAGRAM_ACCESS_TOKEN = "access_token"
    static let INSTAGRAM_SCOPE = "follower_list+public_content" /* add whatever scope you need https://www.instagram.com/developer/authorization/ */
    static var access_token = ""
    static let authURL = "https://api.instagram.com/oauth/authorize"
    static let baseURL = "https://api.instagram.com/v1"
}

//
//  User.swift
//  Follocare
//
//  Created by Francesco Zanoli on 24/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

import Foundation

class User:Equatable{
    var username:String
    var photoProfile:URL
    var followersNumber:Int
    var commentsNumber:Int = 0
    
    let setting = Setting()
    var activeFollowers:Array<String> = []
    
    init(username:String,photo:URL,initFollowers:Int){
        self.username = username
        self.photoProfile = photo
        self.followersNumber = initFollowers
    }
    
    func addFollowers(_ followers:Array<String>){
        self.activeFollowers.append(contentsOf: followers)
        self.activeFollowers = Array(Set(self.activeFollowers))
    }
    
    static func == (lp:User, rp:User) -> Bool {
        return lp.username == rp.username
    }
    
}

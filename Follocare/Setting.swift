//
//  Setting.swift
//  Follocare
//
//  Created by Francesco Zanoli on 24/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

import Foundation

class Setting{
    
    var mediaPerFollower:Int = 3
    var maxCommentPerDay:Int = 200
    //In second
    var commentTiming:Double = 1.0
    var onlyRecentMedia:Bool = false
    let editCommentList = [SettingComment("Amazing edit"),SettingComment("It looks so real"),SettingComment("OMG, great job")]
    let landscapeCommentList = [SettingComment("Amazing edit"),SettingComment("It looks so real"),SettingComment("OMG, great job")]
    let ligthCommentList = [SettingComment("Amazing edit"),SettingComment("It looks so real"),SettingComment("OMG, great job")]
    let compositionCommentList = [SettingComment("Amazing edit"),SettingComment("It looks so real"),SettingComment("OMG, great job")]
    let fireCommentList = [SettingComment("Amazing edit"),SettingComment("It looks so real"),SettingComment("OMG, great job")]
    let randomCommentList = [SettingComment("Amazing edit"),SettingComment("It looks so real"),SettingComment("OMG, great job")]
    let photoCommentList = [SettingComment("Amazing edit"),SettingComment("It looks so real"),SettingComment("OMG, great job")]
    let likeCommentList = [SettingComment("Amazing edit"),SettingComment("It looks so real"),SettingComment("OMG, great job")]
    
    func getLikeComment() -> String{
        return findActiveComment(into: self.likeCommentList, iteration: 0)
    }
    
    func getEditComment() -> String{
        return findActiveComment(into: self.editCommentList, iteration: 0)
    }
    
    func getLandscapeComment() -> String{
        return findActiveComment(into: self.landscapeCommentList, iteration: 0)
    }
    
    func getLightComment() -> String{
        return findActiveComment(into: self.ligthCommentList, iteration: 0)
    }
    
    func getCompositionComment() -> String{
        return findActiveComment(into: self.compositionCommentList, iteration: 0)
    }
    
    func getFireComment() -> String{
        return findActiveComment(into: self.fireCommentList, iteration: 0)
    }
    
    func getRandomComment() -> String{
        return findActiveComment(into: self.randomCommentList, iteration: 0)
    }
    
    func getPhotoComment() -> String{
        return findActiveComment(into: self.photoCommentList, iteration: 0)
    }
    
    private func findActiveComment(into array:Array<SettingComment>, iteration:Int) -> String{
        if iteration+1 >= array.count{
            return ""
        }
        let index = Int(arc4random_uniform(UInt32(array.count)))
        if array[index].active {
            return array[index].text
        }else{
            return findActiveComment(into:array,iteration: iteration+1)
        }
    }
    
    func getTotalComments()->Int{
        return 8*3
    }
}

struct SettingComment{
    var text:String
    var active:Bool = true
    
    init(_ commtn:String){
        text = commtn
    }
}

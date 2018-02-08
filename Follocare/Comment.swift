//
//  File.swift
//  Follocare
//
//  Created by Francesco Zanoli on 02/02/2018.
//  Copyright © 2018 Francesco Zanoli. All rights reserved.

//

import Foundation

enum CommentType{
    case Random
    case Landscape
    case Fire
    case Like
    case Composition
    case Light
    case Edit
    case Photo
}

class Comment{
    //var Type:CommentType = .Random
    var Text:String = ""
    var Active:Bool = true
}


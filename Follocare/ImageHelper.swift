//
//  ImageHelper.swift
//  Helphy
//
//  Created by Francesco Zanoli on 08/07/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

import Foundation
import UIKit

enum DefaultImage{
    case Profile,Background,None
}

class ImageHelper{
    static func RetriveImage(atPath imagePath:String?,orDefault defaultType:DefaultImage) -> UIImage{
        guard let path:String = imagePath else {
            return retDefault(for: defaultType)
        }
        guard let image = UIImage(named:path) else {
            return retDefault(for: defaultType)
        }
        return image
    }
    
    static private func retDefault(for defaultType:DefaultImage) -> UIImage{
        var defImage:UIImage
        switch defaultType{
            case .Profile:
                defImage = #imageLiteral(resourceName: "user_filled")
            case .Background:
                defImage = UIImage(named:"11")!
            }
        return defImage
    }
}

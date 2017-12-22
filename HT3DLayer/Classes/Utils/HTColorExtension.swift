//
// Created by yang wang on 2017/12/21.
// Copyright (c) 2017 ocean. All rights reserved.
//

import UIKit
import GLKit

extension UIColor {
    static func randomColor() -> UIColor {
        let r = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let g = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let b = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return UIColor.init(red: r, green: g, blue: b, alpha: 1)
    }

    @_inlineable
    public static func fromVec3(glkVector3: GLKVector3) -> UIColor {
        return UIColor.init(red: CGFloat(glkVector3.x), green: CGFloat(glkVector3.y), blue: CGFloat(glkVector3.z), alpha: 1)
    }
}


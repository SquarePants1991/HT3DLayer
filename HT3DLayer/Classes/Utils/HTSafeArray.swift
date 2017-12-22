//
//  HTSafeArray.swift
//  CA3D
//
//  Created by yang wang on 2017/12/20.
//  Copyright © 2017年 ocean. All rights reserved.
//

import CoreGraphics
import GLKit

extension CGFloat {
    static func *(left: CGFloat, right: Float) -> Float {
        return Float(left) * right
    }
    
    static func *(left: Float, right: CGFloat) -> CGFloat {
        return CGFloat(left) * right
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return index <= self.count - 1 ? self[index] : nil
    }
    
    subscript(cycle index: Int) -> Element? {
        return self[index % self.count]
    }
}

//
// Created by yang wang on 2017/12/20.
// Copyright (c) 2017 ocean. All rights reserved.
//

import GLKit
import UIKit

extension CGPoint {
    static func +(point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint.init(x: point.x + scalar, y: point.y + scalar)
    }

    static func +(point: CGPoint, scalar: (CGFloat, CGFloat)) -> CGPoint {
        return CGPoint.init(x: point.x + scalar.0, y: point.y + scalar.1)
    }

    static func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint.init(x: point.x * scalar, y: point.y * scalar)
    }

    static func *(point: CGPoint, scalar: (CGFloat, CGFloat)) -> CGPoint {
        return CGPoint.init(x: point.x * scalar.0, y: point.y * scalar.1)
    }
}

extension GLKVector3 {
    func cgPoint() -> CGPoint {
        return CGPoint.init(x: CGFloat(x), y: CGFloat(y))
    }
}

extension GLKVector4 {
    init(vector3: GLKVector3, w: Float) {
        self.init(v: (vector3.x, vector3.y, vector3.z, w))
    }

    var xyz: GLKVector3 {
        return GLKVector3.init(v: (x, y, z))
    }

    @_inlineable
    public static func *(left: GLKVector4, right: Float) -> GLKVector4 {
        return GLKVector4MultiplyScalar(left, right)
    }

    @_inlineable
    public static func /(left: GLKVector4, right: Float) -> GLKVector4 {
        return GLKVector4MultiplyScalar(left, 1.0 / right)
    }
}

extension GLKMatrix4 {
    @_inlineable
    public static func *(left: GLKMatrix4, right: GLKMatrix4) -> GLKMatrix4 {
        return GLKMatrix4Multiply(left, right)
    }

    @_inlineable
    public static func *(left: GLKMatrix4, right: GLKVector4) -> GLKVector4 {
        return GLKMatrix4MultiplyVector4(left, right)
    }
}